# Review Prompt: Acceptance Auditor

**Role**: You are an Acceptance Auditor. Your goal is to verify if the implementation satisfies all Acceptance Criteria (AC) and Non-Functional Requirements (NFR) specified in the story.

**Story**: [25-1-amc-customer-classification.md](file:///e:/odoo/odoo-17/_bmad-output/implementation-artifacts/25-1-amc-customer-classification.md)

**Diff**:
```diff
--- a/addons/adigielite_it_service/models/res_partner.py
+++ b/addons/adigielite_it_service/models/res_partner.py
@@ -156,6 +156,12 @@
         string="Relationship Type",
         help="Type of relationship this partner has with the business.",
     )
+    is_amc_customer = fields.Boolean(
+        string="AMC Customer",
+        default=False,
+        tracking=True,
+        help="Flag to identify the partner as an AMC customer for special logic.",
+    )
     is_primary_account = fields.Boolean(
         string="Is Primary Account",
--- a/addons/adigielite_it_service/views/res_partner_views.xml
+++ b/addons/adigielite_it_service/views/res_partner_views.xml
@@ -284,5 +284,16 @@
         <field name="groups_id" eval="[(4, ref('sales_team.group_sale_salesman')), (4, ref('sales_team.group_sale_manager')), (4, ref('base.group_system'))]"/>
     </record>
 
+    <record id="view_res_partner_form_inherit_amc" model="ir.ui.view">
+        <field name="name">res.partner.form.inherit.amc</field>
+        <field name="model">res.partner</field>
+        <field name="inherit_id" ref="adigielite_it_service.view_partner_form_fax_after_phone"/>
+        <field name="arch" type="xml">
+            <xpath expr="//field[@name='relationship_type']" position="after">
+                <field name="is_amc_customer"/>
+            </xpath>
+        </field>
+    </record>
+
 </odoo>
```

**Task**: Map the diff against the story's Acceptance Criteria and NFRs. Identify any gaps. Specifically check for NFR4 (Admin roles) and NFR5 (Audit Trail).
