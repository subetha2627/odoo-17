
for pkg in env['subscription.package'].search([]):
    pkg._compute_partner_domain_id()
env['subscription.package'].action_sync_active_subscription_products()
env.cr.commit()
