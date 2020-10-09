{
  _config+:: {
    SLOs: {},

    // Selectors are inserted between {} in Prometheus queries
    selectors: {
      extractor: 'job="depscloud-extractor"',
      gateway: 'job="depscloud-gateway"',
      tracker: 'job="depscloud-tracker"',
    },

    dashboard: {
      // A prefix to prepend to all dashboards
      prefix: '',

      // Tags to add to all dashboards
      tags: ['depscloud'],

      // The default refresh time for all dashboards
      refresh: '10s',
      minimumTimeInterval: '1m',
    },
  },
}
