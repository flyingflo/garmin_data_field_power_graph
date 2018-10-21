using Toybox.WatchUi;
using Toybox.Graphics;
using DataFieldUtils;

class garmin_data_field_power_graphView extends DataFieldUtils.GraphDataField {

	var _val_avg_len;
    function initialize() {
        GraphDataField.initialize();
        _ref_value = "0000";

        _val_avg_len = 3;
        label = "Power";
        if (_val_avg_len > 0) {
        	label += " [" + _val_avg_len + "s]";
        }
        value = "___";

    }

    function fetchSettings() {
		_histlen = 210;
		_y_min = 100;
		_y_max = 500;
		_y_thresh = 320 - _y_min;
		_colors_bright = [Graphics.COLOR_TRANSPARENT, 0x0055ff, 0xff5500, 0xff00ff];
		_colors_dark = [Graphics.COLOR_TRANSPARENT, 0x0000aa, 0xaa5500, 0xaa55ff];
		_scale_x = false;
    }


    // The given info object contains all the current workout information.
    // Calculate a value and save it locally in this method.
    // Note that compute() and onUpdate() are asynchronous, and there is no
    // guarantee that compute() will be called before onUpdate().
    function compute(info) {
        // See Activity.Info in the documentation for available information.
        var p = null;
        if(!(info has :currentPower)){
        	value = "???";
        	return;
        }
		p = info.currentPower;
		if(info.currentPower == null){
			value = "___";
			pushGraph(0);
			return;
		}
		pushGraph(p);
		var v;
		if (_val_avg_len == 0) {
			v = p;
		} else {
			var acc = p;
			for (var i = -2; i >= -_val_avg_len; i--) {
				acc += gethist(i);
			}
			v = acc / _val_avg_len;
		}
		value = v.format("%d");

    }


}
