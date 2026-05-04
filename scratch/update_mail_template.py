
template = env.ref('sale.email_template_edi_sale')
template.subject = "{{ object.company_id.name }} {{ object.state in ('draft', 'sent') and (object.env.context.get('proforma') and 'PRO-FORMA Invoice' or 'Quotation') or 'Order' }} (Ref {{ object.name or 'n/a' }})"
template.body_html = """
<div style="margin: 0px; padding: 0px;">
    <p style="margin: 0px; padding: 0px; font-size: 13px;">
        <t t-set="doc_name" t-value="'PRO-FORMA Invoice' if object.env.context.get('proforma') else ('quotation' if object.state in ('draft', 'sent') else 'order')"/>
        Hello,
        <br/><br/>
        Your
        <t t-if="object.env.context.get('proforma')">
            PRO-FORMA Invoice <span style="font-weight: bold;" t-out="object.name or ''">S00052</span>
            <t t-if="object.origin">
                (with reference: <t t-out="object.origin or ''"/>)
            </t>
            amounting in <span style="font-weight: bold;" t-out="format_amount(object.amount_total, object.currency_id) or ''">$ 10.00</span> is available.
        </t>
        <t t-else="">
            <t t-out="doc_name or ''">quotation</t> <span style="font-weight: bold;" t-out="object.name or ''"/>
            <t t-if="object.origin">
                (with reference: <t t-out="object.origin or ''">S00052</t>)
            </t>
            amounting in <span style="font-weight: bold;" t-out="format_amount(object.amount_total, object.currency_id) or ''">$ 10.00</span> is ready for review.
        </t>
        <br/><br/>
        Do not hesitate to contact us if you have any questions.
        <t t-if="not is_html_empty(object.user_id.signature)">
            <br/><br/>
            <t t-out="object.user_id.signature or ''">--<br/>Mitchell Admin</t>
        </t>
        <br/><br/>
    </p>
</div>
"""

report = env.ref('sale.action_report_saleorder')
report.print_report_name = "(object.state in ('draft', 'sent') and (object.env.context.get('proforma') and 'PRO-FORMA Invoice - %s' % (object.name) or 'Quotation - %s' % (object.name))) or 'Order - %s' % (object.name)"
env.cr.commit()
