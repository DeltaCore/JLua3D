package net.ccmob.jlua3d.core;

import java.awt.Color;
import java.awt.Font;

import net.ccmob.jlua3d.gui.GraphicFrame;

import org.luaj.vm2.Globals;
import org.luaj.vm2.LuaValue;
import org.luaj.vm2.lib.OneArgFunction;
import org.luaj.vm2.lib.ThreeArgFunction;
import org.luaj.vm2.lib.TwoArgFunction;
import org.luaj.vm2.lib.ZeroArgFunction;
import org.luaj.vm2.lib.jse.JsePlatform;

public class CoreHandler {

	static Globals globals;
	static LuaValue sys_exec;
	static long c = System.nanoTime();
	static long previousTime = System.nanoTime();
	static double delta = 0;

	public static int gr2d_height = 800;
	public static int gr2d_width = 800;
	public static String gr2d_font = "Arial";

	public static int currentX = 0;
	public static int currentY = 0;
	public static int currentR = 0;
	public static int currentG = 0;
	public static int currentB = 0;
	public static int currentA = 0;

	public static void init() {
		globals = JsePlatform.standardGlobals();

		globals.set("GR2D_setXY", new TwoArgFunction() {
			@Override
			public LuaValue call(LuaValue x, LuaValue y) {
				CoreHandler.currentX = x.checkint();
				CoreHandler.currentY = y.checkint();
				return null;
			}
		});
		globals.set("GR2D_setRGB", new ThreeArgFunction() {
			@Override
			public LuaValue call(LuaValue r, LuaValue g, LuaValue b) {
				CoreHandler.currentR = r.checkint();
				CoreHandler.currentG = g.checkint();
				CoreHandler.currentB = b.checkint();
				return null;
			}
		});
		globals.set("GR2D_setAlpha", new OneArgFunction() {
			@Override
			public LuaValue call(LuaValue a) {
				CoreHandler.currentA = a.checkint();
				return null;
			}
		});
		globals.set("GR2D_drawRect", new TwoArgFunction() {
			@Override
			public LuaValue call(LuaValue x, LuaValue y) {
				GraphicFrame.gr.setColor(new Color(currentR, currentG,
						currentB, currentA));
				GraphicFrame.gr.fillRect(currentX, currentY, x.checkint(),
						y.checkint());
				GraphicFrame.gr.fillRect(currentX, currentY, x.checkint(), y.checkint());
				return null;
			}
		});
		globals.set("GR2D_drawArc", new ThreeArgFunction() {
			@Override
			public LuaValue call(LuaValue rad, LuaValue aS, LuaValue aE) {
				GraphicFrame.gr.setColor(new Color(currentR, currentG,
						currentB, currentA));
				GraphicFrame.gr.fillArc(currentX, currentY, rad.checkint(),
						rad.checkint(), aS.checkint(), aE.checkint());
				return null;
			}
		});
		globals.set("GR2D_clearAll", new ThreeArgFunction() {
			@Override
			public LuaValue call(LuaValue r, LuaValue g, LuaValue b) {
				GraphicFrame.gr.setColor(new Color(r.checkint(), g.checkint(),
						b.checkint()));
				GraphicFrame.gr.fillRect(0, 0, gr2d_width, gr2d_height);
				return null;
			}
		});
		globals.set("GR2D_setPixel", new ZeroArgFunction() {
			@Override
			public LuaValue call() {
				GraphicFrame.gr.setColor(new Color(currentR, currentG,
						currentB, currentA));
				GraphicFrame.gr.fillRect(currentX, currentY, currentX + 2,
						currentY + 2);
				return null;
			}
		});
		globals.set("SYS_getDelta", new ZeroArgFunction() {
			@Override
			public LuaValue call() {
				return LuaValue.valueOf(delta);
			}
		});
		globals.set("GR2D_placeText", new TwoArgFunction() {
			@Override
			public LuaValue call(LuaValue text, LuaValue fSize) {
				GraphicFrame.gr.setColor(new Color(currentR, currentG, currentB, currentA));
				GraphicFrame.gr.setFont(new Font(gr2d_font, Font.PLAIN, fSize.checkint()));
				GraphicFrame.gr.drawString(text.checkjstring().toString(), currentX, currentY);
				return null;
			}
		});
		
		globals.set("GR2D_HEIGHT", LuaValue.valueOf(gr2d_height));
		globals.set("GR2D_WIDTH", LuaValue.valueOf(gr2d_width));

		globals.set("SYS_GETMILLITIME", new ZeroArgFunction() {
			@Override
			public LuaValue call() {
				return LuaValue.valueOf(System.nanoTime()/1000000);
			}
		});
		globals.loadfile("res/nativlib.lua").call();
		globals.loadfile("res/main.lua").call();

		sys_exec = globals.get("SYS_execute");
	}

	public static void run() {
		c = System.nanoTime();
		delta = ((double) (c - previousTime)) / 1000000000.0f;
		previousTime = c;
		sys_exec.call();
	}

	public static void execute() {
		while (true) {
			GraphicFrame.instance.repaint();
		}
	}

}
