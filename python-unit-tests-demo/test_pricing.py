"""
Databricks Python unit testing demo.
Realistic tests for pricing helpers — one failing test you can fix in the demo.
"""

from pricing import format_currency, item_subtotal, free_shipping_eligible


class TestPricing():
    def test_format_currency(self):
        assert format_currency(12.5) == "$12.50"
        assert format_currency(0) == "$0.00"

    def test_item_subtotal(self):
        assert item_subtotal(10.0, 3) == 30.0
        assert item_subtotal(4.99, 2) == 9.98

    def test_free_shipping_eligible_above_threshold(self):
        assert free_shipping_eligible(75.0) is True
        assert free_shipping_eligible(50.01) is True

    def test_free_shipping_eligible_at_threshold(self):
        """$50.00 should qualify — fix pricing.py by changing > to >= ."""
        assert free_shipping_eligible(50.0) is True  # fails until you fix the bug

    def test_free_shipping_not_eligible_below(self):
        assert free_shipping_eligible(49.99) is False
        assert free_shipping_eligible(0) is False
