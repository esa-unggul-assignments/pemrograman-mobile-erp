from odoo import http
from odoo.http import request
import logging

_logger = logging.getLogger(__name__)


class UserAuthController(http.Controller):

    @http.route('/api/register', auth='public', type='json', methods=['POST'], csrf=False)
    def register(self):
        data = request.jsonrequest
        _logger.info("Received data for registration: %s", data)
        
        email = data['email']
        password = data['password']
        
        if 'email' not in data or 'password' not in data:
            return {'status': 'error', 'message': 'Missing fields'}
        
        existing_user = request.env['user.auth'].sudo().search([('email', '=', email)], limit=1)
        if existing_user:
            return {
                'status': 'error',
                'message': 'User already exists'
            }

        user = request.env['user.auth'].sudo().create({
            'email': data['email'],
            'password': data['password']
        })

        return {'status': 'success', 'message': 'User registered successfully'}

    @http.route('/api/login', auth='public', type='json', methods=['POST'], csrf=False)
    def login(self):
        data = request.jsonrequest
        _logger.info("Received data for login: %s", data)
        
        if 'email' not in data or 'password' not in data:
            return {'status': 'error', 'message': 'Missing fields'}

        user = request.env['user.auth'].sudo().search([
            ('email', '=', data['email']),
            ('password', '=', data['password'])
        ], limit=1)

        if not user:
            return {'status': 'error', 'message': 'Invalid email or password'}

        return {'status': 'success', 'message': 'Login successful'}
