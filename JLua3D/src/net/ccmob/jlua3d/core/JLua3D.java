package net.ccmob.jlua3d.core;

import net.ccmob.jlua3d.gui.GraphicFrame;

public class JLua3D {

	public static void main(String[] args) {
		CoreHandler.init();
		GraphicFrame.instance = new GraphicFrame();
		CoreHandler.execute();
	}

}
