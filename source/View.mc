using Toybox.WatchUi;
using Toybox.Graphics;
using DataFieldUtils;

class garmin_data_field_power_graphView extends DataFieldUtils.GraphDataField {


    function initialize() {
        GraphDataField.initialize();
        label = "Power";
        value = "???";
    }


    // The given info object contains all the current workout information.
    // Calculate a value and save it locally in this method.
    // Note that compute() and onUpdate() are asynchronous, and there is no
    // guarantee that compute() will be called before onUpdate().
    function compute(info) {
        // See Activity.Info in the documentation for available information.
        var p = null;
        if(info has :currentPower){
            if(info.currentPower != null){
                value = info.currentPower.format("%d");
                p = info.currentPower;
                pushGraph(p);
            } else {
                value = "___";
                pushGraph(0);
            }
        }
    }


}
