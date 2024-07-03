from odoo import models, fields

class User(models.Model):
    _name = 'user.auth'
    _description = 'User Authentication'

    email = fields.Char(string='Email', required=True, unique=True)
    password = fields.Char(string='Password', required=True)
