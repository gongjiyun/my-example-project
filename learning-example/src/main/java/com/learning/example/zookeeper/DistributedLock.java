package com.learning.example.zookeeper;

import java.io.IOException;
import java.util.Collections;
import java.util.List;
import java.util.concurrent.CountDownLatch;

import org.apache.zookeeper.CreateMode;
import org.apache.zookeeper.KeeperException;
import org.apache.zookeeper.WatchedEvent;
import org.apache.zookeeper.Watcher;
import org.apache.zookeeper.ZooDefs;
import org.apache.zookeeper.ZooKeeper;
import org.apache.zookeeper.data.Stat;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class DistributedLock implements Watcher {
    private int threadId;
    private ZooKeeper zk = null;
    private String selfPath;
    private String waitPath;
    private String LOG_PREFIX_OF_THREAD;
    private static final int SESSION_TIMEOUT = 10000;
    private static final String GROUP_PATH = "/disLocks";
    private static final String SUB_PATH = "/disLocks/sub";
    private static final String CONNECTION_STRING = "192.168.56.120" + ":2181";
    
    private static final int THREAD_NUM = 10; 

    private CountDownLatch connectedSemaphore = new CountDownLatch(1);

    private static final CountDownLatch threadSemaphore = new CountDownLatch(THREAD_NUM);
    private static final Logger LOG = LoggerFactory.getLogger(DistributedLock.class);
    public DistributedLock(int id) {
        this.threadId = id;
        LOG_PREFIX_OF_THREAD = "����"+threadId+"���̡߳�";
    }
	
    public static void main(String[] args) {
        for(int i=0; i < THREAD_NUM; i++){
            final int threadId = i+1;
            new Thread(){
                @Override
                public void run() {
                    try{
                        DistributedLock dc = new DistributedLock(threadId);
                        dc.createConnection(CONNECTION_STRING, SESSION_TIMEOUT);
                        //GROUP_PATH
                        synchronized (threadSemaphore){
                            dc.createPath(GROUP_PATH, "�ýڵ����߳�" + threadId + "����", true);
                        }
                        dc.getLock();
                    } catch (Exception e){
                        LOG.error("����"+threadId+"���̡߳� �׳����쳣��");
                        e.printStackTrace();
                    }
                }
            }.start();
        }
        try {
            threadSemaphore.await();
            LOG.info("�����߳����н���!");
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
    /**
     * ��ȡ��
     * @return
     */
    private void getLock() throws KeeperException, InterruptedException {
        selfPath = zk.create(SUB_PATH,null, ZooDefs.Ids.OPEN_ACL_UNSAFE, CreateMode.EPHEMERAL_SEQUENTIAL);
        LOG.info(LOG_PREFIX_OF_THREAD+"������·��:"+selfPath);
        if(checkMinPath()){
            getLockSuccess();
        }
    }
    /**
     * �����ڵ�
     * @param path �ڵ�path
     * @param data ��ʼ��������
     * @return
     */
    public boolean createPath( String path, String data, boolean needWatch) throws KeeperException, InterruptedException {
        if(zk.exists(path, needWatch)==null){
            LOG.info( LOG_PREFIX_OF_THREAD + "�ڵ㴴���ɹ�, Path: "
                    + this.zk.create( path,
                    data.getBytes(),
                    ZooDefs.Ids.OPEN_ACL_UNSAFE,
                    CreateMode.PERSISTENT )
                    + ", content: " + data );
        }
        return true;
    }
    /**
     * ����ZK����
     * @param connectString	 ZK��������ַ�б�
     * @param sessionTimeout Session��ʱʱ��
     */
    public void createConnection( String connectString, int sessionTimeout ) throws IOException, InterruptedException {
            zk = new ZooKeeper( connectString, sessionTimeout, this);
            connectedSemaphore.await();
    }
    /**
     * ��ȡ���ɹ�
    */
    public void getLockSuccess() throws KeeperException, InterruptedException {
        if(zk.exists(this.selfPath,false) == null){
            LOG.error(LOG_PREFIX_OF_THREAD+"���ڵ��Ѳ�����...");
            return;
        }
        LOG.info(LOG_PREFIX_OF_THREAD + "��ȡ���ɹ����Ͻ��ɻ");
        Thread.sleep(2000);
        LOG.info(LOG_PREFIX_OF_THREAD + "ɾ�����ڵ㣺"+selfPath);
        zk.delete(this.selfPath, -1);
        releaseConnection();
        threadSemaphore.countDown();
    }
    /**
     * �ر�ZK����
     */
    public void releaseConnection() {
        if ( this.zk !=null ) {
            try {
                this.zk.close();
            } catch ( InterruptedException e ) {}
        }
        LOG.info(LOG_PREFIX_OF_THREAD + "�ͷ�����");
    }
    /**
     * ����Լ��ǲ�����С�Ľڵ�
     * @return
     */
    public boolean checkMinPath() throws KeeperException, InterruptedException {
         List<String> subNodes = zk.getChildren(GROUP_PATH, false);
         Collections.sort(subNodes);
         int index = subNodes.indexOf( selfPath.substring(GROUP_PATH.length()+1));
         switch (index){
             case -1:{
                 LOG.error(LOG_PREFIX_OF_THREAD+"���ڵ��Ѳ�����..."+selfPath);
                 return false;
             }
             case 0:{
                 LOG.info(LOG_PREFIX_OF_THREAD+"�ӽڵ��У��ҹ�Ȼ���ϴ�"+selfPath);
                 return true;
             }
             default:{
                 this.waitPath = GROUP_PATH +"/"+ subNodes.get(index - 1);
                 LOG.info(LOG_PREFIX_OF_THREAD+"��ȡ�ӽڵ��У�������ǰ���"+waitPath);
                 try{
                     zk.getData(waitPath, true, new Stat());
                     return false;
                 }catch(KeeperException e){
                     if(zk.exists(waitPath,false) == null){
                         LOG.info(LOG_PREFIX_OF_THREAD+"�ӽڵ��У�������ǰ���"+waitPath+"��ʧ�٣��Ҹ�����̫ͻȻ?");
                         return checkMinPath();
                     }else{
                         throw e;
                     }
                 }
             }
                 
         }
     
    }

	@Override
	public void process(WatchedEvent event) {
		if(event == null){
            return;
        }
        Event.KeeperState keeperState = event.getState();
        Event.EventType eventType = event.getType();
        if ( Event.KeeperState.SyncConnected == keeperState) {
            if ( Event.EventType.None == eventType ) {
                LOG.info( LOG_PREFIX_OF_THREAD + "�ɹ�������ZK������" );
                connectedSemaphore.countDown();
            }else if (event.getType() == Event.EventType.NodeDeleted && event.getPath().equals(waitPath)) {
                LOG.info(LOG_PREFIX_OF_THREAD + "�յ��鱨������ǰ��ļһ��ѹң����ǲ��ǿ��Գ�ɽ�ˣ�");
                try {
                    if(checkMinPath()){
                        getLockSuccess();
                    }
                } catch (KeeperException e) {
                    e.printStackTrace();
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        }else if ( Event.KeeperState.Disconnected == keeperState ) {
            LOG.info( LOG_PREFIX_OF_THREAD + "��ZK�������Ͽ�����" );
        } else if ( Event.KeeperState.AuthFailed == keeperState ) {
            LOG.info( LOG_PREFIX_OF_THREAD + "Ȩ�޼��ʧ��" );
        } else if ( Event.KeeperState.Expired == keeperState ) {
            LOG.info( LOG_PREFIX_OF_THREAD + "�ỰʧЧ" );
        }
	}

}
