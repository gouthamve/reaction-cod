reaction-stripe
=============

Meteor package adds Stripe Payments for Reaction Commerce.

This is a prototype module -> pull requests are celebrated, feedback encouraged.

**Usage**
```bash
meteor add reactioncommerce:reaction-stripe
```
*Note: Stripe automatically infers sandbox vs production mode based on API key used.*

*Note: this package automatically converts the total charge amount into smallest currency units as is required by Stripe before the API call is made.*

For information on the **charge** object returned see [Stripe's Charges Documentation](https://stripe.com/docs/api#charges)
