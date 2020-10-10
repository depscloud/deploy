{
  _config+:: {
    // indexer specific configuration
    indexer: {
      selector: 'job="depscloud-indexer"',
      slos: {},
    },

    dashboard: {
      // A prefix to prepend to all dashboards
      prefix: '',

      // Tags to add to all dashboards
      tags: ['depscloud'],

      // The default refresh time for all dashboards
      refresh: '10s',
    },
  },
}
