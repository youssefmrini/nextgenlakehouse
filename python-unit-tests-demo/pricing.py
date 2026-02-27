"""
Pricing helpers for an order flow.
Small, realistic module for unit testing demos.
"""


def format_currency(amount: float) -> str:
    """Format amount as USD, e.g. 12.5 -> '$12.50'."""
    return f"${amount:.2f}"


def item_subtotal(unit_price: float, quantity: int) -> float:
    """Compute line total: unit_price * quantity."""
    return unit_price * quantity


def free_shipping_eligible(subtotal: float) -> bool:
    """True if order qualifies for free shipping (subtotal >= 50)."""
    return subtotal > 50  # bug: should be >= 50 so $50 exactly qualifies
