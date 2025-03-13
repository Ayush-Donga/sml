<?php

function remove_trailing_zeros($num) {
    // Convert number to string
    $num_str = strval($num);

    // Check if the number has a decimal point
    if (strpos($num_str, '.') !== false) {
        // Remove trailing zeros after decimal point
        $num_str = rtrim($num_str, '0');
        // Remove decimal point if no digits remain after
        if (substr($num_str, -1) == '.') {
            $num_str = substr($num_str, 0, -1);
        }
    }

    return $num_str;
}

function invoiceDepartmentColor($order, $defaultColorCode, $yellowColorCode) {
    $fields = [
        'country', 'serve_date',
        'bill_to_customer_id', 'bill_to_client_code', 'bill_to_company_name',
        'bill_to_phone_no', 'bill_to_address',
        'ship_to_customer_id', 'ship_to_client_code', 'ship_to_company_name',
        'ship_to_phone_no', 'ship_to_address'
    ];
    foreach ($fields as $field) {
        if ($order->$field === null) {
            return $yellowColorCode;
        }
    }
    return $defaultColorCode;
}

function bdDepartmentColor($order, $defaultColorCode, $yellowColorCode) {
     
    if ($order->orderProducts->isEmpty()) {
        return   $yellowColorCode;
    }

    $fields = [
        'product_id', 'product_variant_id','quantity'
    ];

    foreach ($fields as $field) {
        foreach ($order->orderProducts as $product) {
            if ($product->$field === null) {
                return $yellowColorCode;
            }
        }
    }

    return $defaultColorCode;
}

function purchaseDepartmentColor($order, $defaultColorCode, $yellowColorCode) {
    $allOrdersPlaced = true;
    $hasErrorWithNotes = false;
    
    foreach ($order->orderProducts as $product) {
        if ($product->is_order_placed === null) {
            return $yellowColorCode;
        } elseif ($product->is_order_placed === 'yes') {
            if ($product->expected_delivery_date === null) {
                $allOrdersPlaced = false;
            }
        } elseif ($product->is_order_placed === 'no' || $product->is_order_placed === 'error') {
            if ($product->note !== null) {
                $hasErrorWithNotes = true;
            }
        }
    }

    if (!$allOrdersPlaced) {
        return $yellowColorCode;
    } elseif ($hasErrorWithNotes) {
        return $defaultColorCode;
    }

    return $defaultColorCode;
}

function checkPurchaseIssues($order) {
    $hasIssue = true;
    
    foreach ($order->orderProducts as $product) {
        if ($product->is_order_placed === null) {
            $hasIssue = false;
            break; 
        }
    }
    
    return $hasIssue;
}

function warehouseDepartmentColor($order, $defaultColorCode, $yellowColorCode) {
    $checkStatus = checkPurchaseIssues($order);

    if($checkStatus){
        // Flag to track if there is at least one issue
        $hasIssue = false;
        
        foreach ($order->orderProducts as $orderProduct) {
            // If there are no stocks for this product, immediately return yellow
            if ($orderProduct->orderProductStocks->isEmpty()) {
                return $yellowColorCode;
            }

            foreach ($orderProduct->orderProductStocks as $productStock) {
                // Check if stock is missing
                if ($productStock->is_stock_received === null) {
                    $hasIssue = true;
                    break; // No need to check further if stock is missing
                }

                // Check if stock is received but required fields are missing
                if ($productStock->is_stock_received === 'yes' && (
                    $productStock->batch_no === null ||
                    $productStock->mfg_date === null ||
                    $productStock->exp_date === null ||
                    $productStock->quantity === null)) {
                    $hasIssue = true;
                }

                // Check if stock is not received and all required fields are null
                if ($productStock->is_stock_received === 'no' && (
                    $productStock->batch_no !== null ||
                    $productStock->mfg_date !== null ||
                    $productStock->exp_date !== null ||
                    $productStock->quantity !== null)) {
                    $hasIssue = true;
                }

                // If any issue found, return yellow immediately
                if ($hasIssue) {
                    return $yellowColorCode;
                }
            }
        }
    }

    // If no issues found, return default color code
    return $defaultColorCode;
}

function checkWarehouseIssues($order){
    $hasIssue = true; 
    foreach ($order->orderProducts as $orderProduct) {
        foreach ($orderProduct->orderProductStocks as $productStock) {
            if ($productStock->is_stock_received === null) {
                $hasIssue = false;
                break 2; 
            }
        }
    }

    return $hasIssue;
}

function billingDepartmentColor($order, $defaultColorCode, $yellowColorCode) {
    $checkStatus = checkWarehouseIssues($order);

    if($checkStatus){
        foreach ($order->orderProducts as $orderProduct) {
            foreach ($orderProduct->orderProductStocks as $productStock) {
                if ($productStock->is_purchase_entry_done === null) {
                    return $yellowColorCode;
                } 
            }
        }
    }
    
    return $defaultColorCode;
}

function checkStockIssues($order) {
    $hasIssue = false; 

    foreach ($order->orderProducts as $orderProduct) {
        foreach ($orderProduct->orderProductStocks as $productStock) {
            if ($productStock->is_purchase_entry_done !== null) {
                $hasIssue = true;
                break 2; 
            }
        }
    }

    return $hasIssue;
}

function wareHousePackingListDepartmentColor($order, $defaultColorCode, $yellowColorCode) {
$hasIssue = checkStockIssues($order);

    if ($hasIssue) {
        if ($order->orderPackages->isEmpty()) {
            return $yellowColorCode;
        }

        $fields = ['order_id', 'box_no', 'dimension', 'gross_weight', 'net_weight'];
        foreach ($fields as $field) {
            foreach ($order->orderPackages as $package) {
                if ($package->$field === null) {
                    return $yellowColorCode;
                }
            }
        }
    }

    return $defaultColorCode;
}

function logisticDepartmentColor($order, $defaultColorCode, $yellowColorCode) {
    
        $fields = [
            'is_shipping_documents_done', 'is_tax_invoice_eway_billP_done', 'is_arrange_pick_up',
            'is_shipment_dispatched', 'is_awb_handover', 'is_shipment_close'
        ];

        if (count($order->orderPackages) > 0) {
            foreach ($fields as $field) {
                foreach ($fields as $field) {
                    if ($order->$field === null) {
                        return $yellowColorCode;
                    }
                }
            }
        }

    return $defaultColorCode;
}

function departmentWiseColor($orders) {
    $defaultColorCode = '#fff';
    $yellowColorCode = '#fce8b2';
    $redColorCode = '#f4c7c3';

    $departmentWiseInfo = [];

    foreach ($orders as $order) {
        $invoiceDepartmentColor = invoiceDepartmentColor($order, $defaultColorCode, $yellowColorCode);
        $bdDepartmentColor = bdDepartmentColor($order, $defaultColorCode, $yellowColorCode);
        $purchaseDepartmentColor = purchaseDepartmentColor($order, $defaultColorCode, $yellowColorCode);
        $warehouseDepartmentColor = warehouseDepartmentColor($order, $defaultColorCode, $yellowColorCode);
        $billingDepartmentColor = billingDepartmentColor($order, $defaultColorCode, $yellowColorCode);
        $wareHousePackingListDepartmentColor = wareHousePackingListDepartmentColor($order, $defaultColorCode, $yellowColorCode);
        $logisticDepartmentColor = logisticDepartmentColor($order, $defaultColorCode, $yellowColorCode);

        $orderInfo = [
            'id' => $order->id,
            'invoice_department_color' => $invoiceDepartmentColor,
            'bd_department_color' => $bdDepartmentColor,
            'purchase_department_color' => $purchaseDepartmentColor,
            'warehouse_department_color' => $warehouseDepartmentColor,
            'billing_department_color' => $billingDepartmentColor,
            'wareHousePackingList_department_color' => $wareHousePackingListDepartmentColor,
            'logistic_department_color' => $logisticDepartmentColor,
        ];

        $departmentWiseInfo[] = $orderInfo;
    }

    return $departmentWiseInfo;
}

// Function to merge colors with orders
function mergeColorsWithOrders($orders, $colors) {
    $colorsCollection = collect($colors);

    return $orders->map(function ($order) use ($colorsCollection) {
        $color = $colorsCollection->firstWhere('id', $order->id);
        $orderArray = $order->toArray();
        $mergedData = array_merge($orderArray, $color);
        $mergedData['orderProducts'] = $order->orderProducts;
        $mergedData['orderPackages'] = $order->orderPackages;

        return (object) $mergedData;
    });
}


// BD department to calculate totalValue including additional fields
function calculateTotalValue($order) {
    $totalValue = 0;

    // Summing up totals from orderProducts
    foreach ($order->orderProducts as $orderProduct) {
        $totalValue += $orderProduct->total;
    }

    // Adding additional fields to totalValue
    $totalValue += $order->shipping;
    $totalValue += $order->soft_boxes;
    $totalValue += $order->data_logger;
    $totalValue += $order->clearance;

    return $totalValue;
}

// BD department to calculate sub totalValue 
function calculateSubTotalValue($order) {
    $totalValue = 0;

    // Summing up totals from orderProducts
    foreach ($order->orderProducts as $orderProduct) {
        $totalValue += $orderProduct->total;
    }

    return $totalValue;
}

function warehouseIssueCheck($order) {
    $hasIssue = false; 
    foreach ($order->orderProducts as $orderProduct) {
        foreach ($orderProduct->orderProductStocks as $productStock) {
            if ($productStock->is_stock_received !== null) {
                $hasIssue = true;
                break 2; 
            }
        }
    }

    return $hasIssue;
}

function bdIssueCheck($order){
    $hasIssue = false; 
    foreach ($order->orderProducts as $orderProduct) {
            if ($orderProduct->id !== null) {
                $hasIssue = true;
                break; 
            }
    }

    return $hasIssue;
}


function proformaBDIssueCheck($proforma){
    $hasIssue = false; 
    foreach ($proforma->proformaProducts as $proformaProduct) {
            if ($proformaProduct->id !== null) {
                $hasIssue = true;
                break; 
            }
    }

    return $hasIssue;
}

// Proforma BD department to calculate totalValue including additional fields
function calculateProformaBdTotalValue($proforma) {
    $totalValue = 0;

    // Summing up totals from orderProducts
    foreach ($proforma->proformaProducts as $proformaProduct) {
        $totalValue += $proformaProduct->total;
    }

    // Adding additional fields to totalValue
    $totalValue += $proforma->shipping;
    $totalValue += $proforma->soft_boxes;
    $totalValue += $proforma->data_logger;
    $totalValue += $proforma->clearance;

    return $totalValue;
}

function calculateProformaSubTotalValue($proforma){
    $totalValue = 0;

    // Summing up totals from orderProducts
    foreach ($proforma->proformaProducts as $proformaProduct) {
        $totalValue += $proformaProduct->total;
    }

    return $totalValue;
}

if (!function_exists('format_currency')) {
    function format_currency($amount, $currency = 'INR', $decimals = 2)
    {
        $symbol = match ($currency) {
            'USD' => '$',
            'EUR' => '€',
            'GBP' => '£',
            'JPY' => '¥',
            'INR' => '', // ₹
            default => '',
        };

        // Format the number with Indian numbering format for INR, else use international format
        if ($currency === 'INR') {
            // Custom formatting for Indian numbering system
            $result = explode('.', number_format($amount, $decimals, '.', ''));

            // Extract the integer and decimal parts
            $integerPart = $result[0];
            $decimalPart = isset($result[1]) ? $result[1] : '00';

            // Apply Indian numbering system formatting
            $lastThree = substr($integerPart, -3);
            $otherNumbers = substr($integerPart, 0, -3);
            if (strlen($otherNumbers) > 0) {
                $lastThree = ',' . $lastThree;
            }
            $formattedInteger = preg_replace('/\B(?=(\d{2})+(?!\d))/', ',', $otherNumbers) . $lastThree;

            // Combine formatted parts
            $formatted = $formattedInteger . '.' . $decimalPart;
        } else {
            // Standard formatting
            $formatted = number_format($amount, $decimals, '.', ',');
        }

        // Append or prepend currency symbol based on region
        if (in_array($currency, ['USD', 'GBP', 'JPY', 'INR'])) {
            return $symbol . $formatted;
        } else {
            return $formatted . ' ' . $symbol;
        }
    }
}

function validateField($quotationData, $quotationField, $request, $quotationIndex)
{
    if (Str::contains($quotationField, 'supplier.*')) {
        // Handle supplier array fields
        $supplierField = str_replace('supplier.*.', '', $quotationField);
        return !empty($quotationData['supplier']) &&
               collect($quotationData['supplier'])->every(fn($s) => !empty($s[$supplierField]));
    } elseif ($quotationField === 'product_photos') {
        // Handle product photos validation
        return $request->hasFile("quotation.$quotationIndex.product_photos");
    } elseif ($quotationField === 'product_documents') {
        // Handle product documents validation
        return $request->hasFile("quotation.$quotationIndex.product_documents");
    } else {
        // General validation for single fields
        return !empty(data_get($quotationData, $quotationField));
    }
}

function addNotificationIdToUrl($url, $notificationId)
{
    // Parse the original URL into components
    $parsedUrl = parse_url($url);

    // Convert existing query into an array
    $queryArray = [];
    if (isset($parsedUrl['query'])) {
        parse_str($parsedUrl['query'], $queryArray);
    }

    // Add or update notification_id
    $queryArray['notification_id'] = $notificationId;

    // Build new query
    $newQuery = http_build_query($queryArray);

    // Now rebuild the URL step by step
    $scheme = $parsedUrl['scheme'] ?? null;
    $host   = $parsedUrl['host']   ?? null;
    $port   = isset($parsedUrl['port']) ? ':' . $parsedUrl['port'] : '';
    $path   = $parsedUrl['path']   ?? '';

    // Start with scheme://host:port/path if present
    $updatedUrl = '';
    if ($scheme && $host) {
        $updatedUrl = $scheme . '://' . $host . $port . $path;
    } else {
        // If no full scheme and host, we might be dealing with a relative URL
        // e.g. "/orders" or "orders"
        $updatedUrl = $path;
    }

    // Re-append the new query
    if (!empty($newQuery)) {
        $updatedUrl .= '?' . $newQuery;
    }

    // Keep the fragment (#...) if it exists
    if (isset($parsedUrl['fragment'])) {
        $updatedUrl .= '#' . $parsedUrl['fragment'];
    }

    return $updatedUrl;
}






