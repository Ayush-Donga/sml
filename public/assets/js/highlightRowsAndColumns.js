document.addEventListener('DOMContentLoaded', () => handleHashChanges());

function handleHashChanges() {
    const hashParams = new URLSearchParams(window.location.hash.slice(1));
    if (!hashParams) return;
    handleHighlight(hashParams.get('products'), 'data-highlight-product-id', 'row-highlight');
    handleOrderHighlight(hashParams.get('order'), hashParams.get('fields'));
    handleUpdated(hashParams.get('updatedProducts'), 'product');
    handleHighlight(hashParams.get('purchase'), 'data-highlight-purchase-id', 'row-highlight');
    handleUpdated(hashParams.get('updatedPurchases'), 'purchase');
    handleHighlight(hashParams.get('productStocks'), 'data-highlight-product-stock-id', 'row-highlight');
    handleUpdated(hashParams.get('updatedStocks'), 'product-stock');
    handleHighlight(hashParams.get('billing'), 'data-highlight-billing-id', 'row-highlight');
    handleHighlight(hashParams.get('package'), 'data-highlight-package-id', 'row-highlight');
    handleHighlight(hashParams.get('packageProduct'), 'data-highlight-package-product-id', 'row-highlight');
    handleUpdated(hashParams.get('updatedPackages'), 'package');
    handleUpdated(hashParams.get('updatedPackageProducts'), 'package-product');
}

function handleHighlight(param, attribute, highlightClass) {
    if (!param) return;
    const ids = decodeParam(param).split(',').filter(Boolean);
    ids.forEach(id => highlightElements(`[${attribute}="${id}"]`, highlightClass));
}

function handleOrderHighlight(orderParam, fieldsParam) {
    const orderId = decodeParam(orderParam);
    const fields = decodeParam(fieldsParam)?.split(',').filter(Boolean);
    if (orderId && fields) {
        fields.forEach(field => 
            highlightElements(`[data-highlight-order-id="${orderId}"][data-field="${field}"]`, 'row-highlight')
        );
    }
}

function handleUpdated(param, attribute) {
    const data = safelyParseJSON(decodeParam(param));
    console.log('data', data)
    console.log('attribute', attribute)
    if (!data) return;
    data?.forEach(({ id, fields }) => {
        fields?.forEach(field => 
            highlightElements(`[data-field="${field}"][data-highlight-${attribute}-id="${id}"]`, 'cell-highlight')
        );
        // highlightElements(`[data-highlight-${attribute}-id="${id}"]`, 'row-highlight');
    });
}

function highlightElements(selector, highlightClass) {
    document.querySelectorAll(selector).forEach(el => el.classList.add(highlightClass));
}

function decodeParam(param) {
    try {
        return param ? decodeURIComponent(param) : null;
    } catch (e) {
        console.error('Error decoding parameter:', e);
        return null;
    }
}

function safelyParseJSON(jsonString) {
    try {
        return JSON.parse(jsonString);
    } catch (e) {
        console.error('Error parsing JSON:', e);
        return null;
    }
}
