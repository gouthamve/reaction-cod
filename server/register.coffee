ReactionCore.registerPackage
  name: 'reaction-cod' # usually same as meteor package
  autoEnable: true # auto-enable in dashboard
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

    # configures template for checkout
    # paymentMethod dynamic template
    {
      template: 'codPaymentForm'
      provides: 'paymentMethod'
    }
  ]