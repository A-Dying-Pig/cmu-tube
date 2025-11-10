var CustomBitrateRule;

/**
 * This function defines your custom rule which is bound
 * to the Player. For the sake of this project, you only 
 * need to implement the logic in getSwitchRequest, although
 * you may find it helpful to define some helper functions. 
 */
function CustomBitrateRule() {
    let factory = dashjs.FactoryMaker;
    let SwitchRequest = factory.getClassFactoryByName('SwitchRequest');
    let context = this.context; // This is the global dash.js context
    let instance;

    // TODO: Initialize BBA-0 parameters here

    /**
     * TODO: You can add some initialization logic here
     * This function is called at the start of the playback. 
     * You may find it helpful to initialize state variables in this 
     * function. 
     */
    function initRule() {}

    /**
     * This is the function that gets invoked when the dash.js player
     * wants to check if a quality switch is required. Your main logic
     * belongs in this function
     * 
     * @param ruleCtx - RulesContext of your ABR algorithm, see writeup
     * for more information/documentation 
     * 
     * @returns SwitchRequest - contains the next representation
     */
    function getSwitchRequest(ruleCtx) {
        const mediaInfo = ruleCtx.getMediaInfo();
        
        // We limit the scope of this project to video streams
        if (mediaInfo.type !== 'video') {
            return SwitchRequest(context).create();
        }

        // TODO: Implement your ABR rule below.
        // You may find it helpful to reference the write up for  
        // - How to get current and list of available representations(aka chunk qualities)
        // - How to create/initialize a SwitchRequest to signal change in quality
        
        // Return empty switch request if no quality change is needed
        return SwitchRequest(context).create();
    }

    /**
     * Some helper function ideas to get you started. The function to get the current
     * buffer level is provided to you as an example of how you could access the metrics
     */
    function getCurrentBufferLevel(context) {
        // Creates factory functions of MetricsModel and DashMetrics
        const MetricsModel = dashjs.FactoryMaker.getSingletonFactoryByName('MetricsModel');
        const DashMetrics = dashjs.FactoryMaker.getSingletonFactoryByName('DashMetrics');

        // Creates instance of metricsModel + dashMetrics using existing context
        const metricsModel = MetricsModel(context).getInstance();
        const dashMetrics = DashMetrics(context).getInstance();
        const metrics = metricsModel.getMetricsFor('video', true);

        var buf = dashMetrics.getCurrentBufferLevel('video', metrics) || -1;
        return buf;
    }

    /**
     * You may find this helpful to implement for Part 2 if you would also like 
     * to consider throughput for your custom ABR
     * 
     * See ThroughputController example in the writeup for tips on how to
     * implement. 
     * @returns Current throughput
     */
    function getNetworkThroughput() {
        return 0;
    }

    instance = {
        getSwitchRequest: getSwitchRequest
    };

    initRule();
    return instance;
}

CustomBitrateRule.__dashjs_factory_name = 'CustomBitrateRule';
CustomBitrateRule = dashjs.FactoryMaker.getClassFactory(CustomBitrateRule);