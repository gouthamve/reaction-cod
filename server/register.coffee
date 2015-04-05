ReactionCore.registerPackage
  name: 'reaction-stripe' # usually same as meteor package
  autoEnable: false # auto-enable in dashboard
  settings: # private package settings config (blackbox)
    mode: false
    api_key: ""
  registry: [
    # all options except route and template
    # are used to describe the
    # dashboard 'app card'.
    {
      provides: 'dashboard'
      label: 'COD'
      description: "COD Payment for Reaction Commerce"
      icon: 'fa fa-money' # glyphicon/fa
      cycle: '3' # Core, Stable, Testing (currently testing)
      container: 'dashboard'  #group this with settings
    }
    # configures settings link for app card
    # use 'group' to link to dashboard card
    {
      route: 'stripe'
      provides: 'settings'
      container: 'dashboard'
    }
    # configures template for checkout
    # paymentMethod dynamic template
    {
      template: 'stripePaymentForm'
      provides: 'paymentMethod'
    }
  ]
  # array of permission objects
  permissions: [
    {
      label: "Stripe"
      permission: "dashboard/payments"
      group: "Shop Settings"
    }
  ]
