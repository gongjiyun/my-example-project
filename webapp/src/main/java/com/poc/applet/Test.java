package com.poc.applet;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class Test extends JApplet implements ActionListener, MouseListener,
		MouseMotionListener {
	JButton btnRed, btnGreen, btnBlue;
	JPanel panelColor;
	int x1, y1, x2, y2;
	Color color;

	public void init() {
		panelColor = new JPanel();
		btnRed = new JButton("red");
		btnGreen = new JButton("green");
		btnBlue = new JButton("blue");
		panelColor.setLayout(new FlowLayout());
		panelColor.add(btnRed);
		panelColor.add(btnGreen);
		panelColor.add(btnBlue);
		this.getContentPane().add(panelColor, "North");

		btnRed.addActionListener(this);
		btnGreen.addActionListener(this);
		btnBlue.addActionListener(this);

		this.addMouseListener(this);
		this.addMouseMotionListener(this);
	}

	public void paint(Graphics g) {
		g.setColor(color);
		g.drawLine(x1, y1, x2, y2);
	}

	public void actionPerformed(ActionEvent e) {
		JButton btnSource = (JButton) e.getSource();
		if (btnSource == btnRed) {
			color = Color.red;
		} else if (btnSource == btnGreen) {
			color = Color.green;
		} else if (btnSource == btnBlue) {
			color = Color.blue;
		}
	}

	public void mousePressed(MouseEvent e) {
		x2 = e.getX();
		y2 = e.getY();
	}

	public void mouseReleased(MouseEvent e) {
		//
	}

	public void mouseClicked(MouseEvent e) {
	}

	public void mouseEntered(MouseEvent e) {
	}

	public void mouseExited(MouseEvent e) {
	}

	public void mouseDragged(MouseEvent e) {
		x1 = x2;
		y1 = y2;
		x2 = e.getX();
		y2 = e.getY();
		repaint();
	}

	public void mouseMoved(MouseEvent e) {
	}
}