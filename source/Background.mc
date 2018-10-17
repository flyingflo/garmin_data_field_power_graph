using Toybox.WatchUi;
using Toybox.Application;
using Toybox.Graphics;

class Background extends WatchUi.Drawable {

    hidden var mColor;

    function initialize() {
        var dictionary = {
            :identifier => "Background"
        };

        Drawable.initialize(dictionary);
    }

    function setColor(color) {
        mColor = color;
    }

    function draw(dc) {
        dc.setColor(Graphics.COLOR_BLUE, mColor);
        dc.clear();
        var xlim = dc.getWidth();
        var ylim = dc.getHeight();
        for (var i = 0; i < xlim; i++) {
        	dc.drawLine(i, ylim /3, i, ylim);
    	}
    }

}
