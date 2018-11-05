using Toybox.WatchUi;
using Toybox.Graphics;
using DataFieldUtils;

class garmin_data_field_power_graphView extends DataFieldUtils.GraphDataField {

	var _val_avg_len;
    function initialize() {
        GraphDataField.initialize();
        _ref_value = "0000";

        label = "Power";
        if (_val_avg_len > 0) {
        	label += " [" + _val_avg_len + "s]";
        }
        value = "___";

    }

    function fetchSettings() {
    	// force sensible values
    	if (Application.Properties.getValue("ymin") > Application.Properties.getValue("ymax")) {
    		Application.Properties.setValue("ymax", Application.Properties.getValue("ymin") + 100);
    	}


		_y_min = Application.Properties.getValue("ymin");
		_y_max = Application.Properties.getValue("ymax");
		_y_thresh = Application.Properties.getValue("ythr") - _y_min;

		_colors[:bright] = [Graphics.COLOR_WHITE, 0x00ffff, 0xffaaaa, 0xff55ff];
		_colors[:dark] = [Graphics.COLOR_BLACK, 0x0000ff, 0xaa5500, 0xaa55ff];
		_scale_x = false;

        _val_avg_len = Application.Properties.getValue("valavglen");
        _demo = Application.Properties.getValue("demo");
        _timing = Application.Properties.getValue("timing");
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
