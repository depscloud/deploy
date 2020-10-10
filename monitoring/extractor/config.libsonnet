{
  _config+:: {
    // extractor specific configuration
    extractor: {
      selector: 'job="depscloud-extractor"',
      slos: {
        days: 30,
        availability: 0.99,
      },
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
