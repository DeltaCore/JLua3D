/**
 * 
 */
package net.ccmob.jlua3d.gui;

import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.RenderingHints;

import javax.swing.JFrame;
import javax.swing.JPanel;

import net.ccmob.jlua3d.core.CoreHandler;

/**
 * @author Marcel
 *
 */
public class GraphicFrame extends JFrame {

	/**
	 * 
	 */
	private static final long serialVersionUID = -7762796430883630365L;
	
	public static GraphicFrame instance;
	public static Graphics2D gr;
	
	public GraphicFrame() {
		this.setSize(new Dimension(CoreHandler.gr2d_width,CoreHandler.gr2d_height));
		this.setDefaultCloseOperation(DISPOSE_ON_CLOSE);
		this.add(new GPanel());
		this.setVisible(true);
	}
	
	private class GPanel extends JPanel {
		
		/**
		 * 
		 */
		private static final long serialVersionUID = 4640966185220149750L;

		@Override
		protected void paintComponent(Graphics g) {
			gr = (Graphics2D) g;
			gr.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
			CoreHandler.run();
		}
		
	}
	
}
