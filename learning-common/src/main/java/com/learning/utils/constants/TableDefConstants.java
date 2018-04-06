package com.learning.utils.constants;



public class TableDefConstants{
	public enum CodeMaster {codeMasterId,codeKey,codeValue,type,description};
	public enum SystemSetting {systemSettingId,itemkey,value,category};
	public enum AssetTag {assetTagId,name,status,updatedBy,updatedDate,createdBy,createdDate};
	public enum Group {groupId,name,description,display};
	public enum UserRole {userRoleId,uid,roleId};
	public enum UserGroup {userGroupId,uid,groupId};
	public enum Appointment {appointmentId,customerName,customerNumber,rmName,rmNumber};
	public enum AssetEntryGroup {assetEntryGroupId,classNameId,classPK,groupId,status,updatedBy,updatedDate,createdBy,createdDate};
	public enum Topic {topicId,title,subTitle,summary,detail,url,orgImageResId,thumbnailResId,status,tags,updatedBy,updatedDate,createdBy,createdDate};
	public enum QuickBlox {quickBloxId,uid,quickBloxOwnerId,quickBloxUid,login,fullName,email,phone,website,lastRequestDate,externalUid,blobId,facebookId,twitterId,updatedBy,updatedDate,createdBy,createdDate};
	public enum CalendarItem {calendarItemId,fromDateTime,fromDateTimeStr,toDateTime,toDateTimeStr,startTime,endTime,address,locationLatitude,locationLatitudeStr,locationLongitude,locationLongitudeStr,subject,body,isSynchronized,type,isHighlight,status,remarks,contactName,contactNumber,updatedBy,updatedDate,createdBy,createdDate};
	public enum UserLogin {userLoginId,uid,token,deviceToken,ip,status,loginTime};
	public enum Resource {resourceId,name,type,extension,title,description,fileEntryId,stragety,path,owner,byteContent,size,status,updatedBy,updatedDate,createdBy,createdDate};
	public enum PersonalDocument {personalDocumentId,docTitle,docName,docDate,description,type,signatureDate,uid,resourceId,effectiveStart,effectiveEnd,status,updatedBy,updatedDate,createdBy,createdDate};
	public enum Product {productId,productCode,productName,category,description,thumbnailId,timeToMarket,createdDate,updatedDate,status};
	public enum Event {eventId,hostedByName,hostedByCompanyName};
	public enum MailQueue {mailQueueId,subject,content,html,sendDate,uid,fromUser,toList,ccList,fileEntryIds,isResend,status,remarks,updatedBy,updatedDate,createdBy,createdDate};
	public enum ProductFile {productFileId,productId,resourceId,filename,description,createdBy,createdDate,updatedBy,updatedDate};
	public enum Article {articleId,articleCd,title,subTitle,summary,detail,source,url,orgImageResId,thumbnailResId,status,isHighlight,tags,publishDate,updatedBy,updatedDate,createdBy,createdDate};
	public enum AssetEntryTag {assetEntryTagId,classNameId,classPK,tagId,status,updatedBy,updatedDate,createdBy,createdDate};
	public enum ClientSetting {clientSettingId,uid,itemName,itemValue,category};
	public enum Address {addressId,country,city,street,blockNo,floor,unit,building,postCode,remarks};
	public enum Role {roleId,name,description,displayOrder,display};
	public enum UserProfile {userProfileId,uid,clientId,type,screenName,firstName,lastName,dob,gender,photoId,address,title,occupation,email,mobileNumber,officeNumber,createdBy,createdDate,updatedBy,updatedDate};
	public enum UserDevice {userDeviceId,uid,deviceToken,type};
	public enum ProductMature {productMatureId,productName};
}