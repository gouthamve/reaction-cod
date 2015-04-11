ReactionCore.registerPackage
  name: 'reaction-cod' # usually same as meteor package
  autoEnable: false # auto-enable in dashboard
  settings:
    additionalCharge: 0
    sheetKey: ""
    pincodes: []
  
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
      route: 'cod'
      provides: 'settings'
      container: 'dashboard'
    }
    # configures template for checkout
    # paymentMethod dynamic template
    {
      template: 'codPaymentForm'
      provides: 'paymentMethod'
    }
  ]
  # array of permission objects
  permissions: [
    {
      label: "COD"
      permission: "dashboard/payments"
      group: "Shop Settings"
    }
  ]