<!DOCTYPE html>
<html>

<head>
    <style>
        /** 
            Set the margins of the page to 0, so the footer and the header
            can be of the full height and width!
        **/
        @page {
            margin: 0;
        }

        /** Define the real margins of every page in the PDF **/
        body {
            margin-top: 5cm;
            margin-left: 1.5cm;
            margin-right: 0.5cm;
            margin-bottom: 1cm;
            font-family: Arial, sans-serif;
            position: relative;
        }

        /** Define the header rules **/
        header, footer {
            position: fixed;
            left: 0;
            right: 0.5cm;
            font-family: Arial, sans-serif;
        }

        header {
            top: 0;
            height: 5cm;
            padding-left: 0.5cm;
            padding-top: 1cm;
            border-left: 2.5rem solid #0f8f4d;
        }

        .company-details {
            margin-top: 10px;
            font-size: 11px;
        }

        .heading {
            text-align: right;
            margin-top: -45px;
            color: #5990eb;
        }

        .green-line {
            border: none;
            height: 1px;
            background-color: #0f8f4d;
            width: 100%;
        }

        /** Define the footer rules **/
        footer {
            bottom: 0;
            height: 1.7cm;
            padding-left: 0.5cm;
            text-align: center;
            font-size: 11px;
            border-left: 2.5rem solid #0f8f4d;
        }

        .contact-details {
            font-size: 10px;
            margin-left: 20px;
        }

        .contact-details i {
            margin-right: 5px;
            font-size: 11px;
        }

        .invoice-info {
            float: right;
            font-size: 11px;
        }

        .page-break {
            page-break-before: always;
        }

        table {
            left: 2cm;
            width: 100%;
            border-collapse: collapse;
        }

        table, th, td {
            font-size: 10px;
            border: 1px solid black;
            text-align: center;
        }

        .total-word {
            font-size: 10px;
        }

        .flot-right {
            text-align: right;
        }

        .text-left {
            margin-left: 8px;
        }

        .terms {
            top: 1px;
            padding: 5px;
            font-size: 10px;
            border: 1px solid black;
            word-wrap: break-word; /* Add this to break long words */
        }

        .terms-condition {
            padding-left: 10px;
            font-size: 10px;
        }

        .bill-to {
            font-size: 10px;
            word-wrap: break-word;
            overflow-wrap: break-word;
            max-width: 30%;
        }

        .ship-to {
            font-size: 10px;
            margin-left: 9cm;
            margin-top: -85px;
        }

        /* Add a left border for the body content */
        body::before {
            content: "";
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            border-left: 2.5rem solid #0f8f4d;
        }

        .bg-image{
             /* Background image settings */
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            height: 100%;
            width: 100%;
            background-image: url('{{ $bgLogoBase64 }}');
            background-repeat: no-repeat;
            background-position: center;
            background-size: auto 40%; 
            opacity: 0.2;
        }
    </style>
</head>

<body>
    <!-- Define header and footer blocks before your content -->
    <header>
        @if($logoBase64)
        <img src="{{ $logoBase64 }}" alt="Logo" width="20%">
        @else
        <p>Logo not found</p>
        @endif

        <h2 class="heading">INVOICE</h2>

        <div class="company-details">
            <strong>SPECIALITY MEDICINES LIMITED</strong><br>
            <span><strong>CIN: </strong>U85300GJ2021PTC120022</span>
        </div>

        <hr class="green-line">
    </header>

    <footer>
        <hr class="green-line">
        <div class="contact-details">
            <p>
                <i class="fas fa-map-marker-alt"></i><strong>Corp. Office: </strong>Unit-27, Andheri Sainath Premises
                Co-operative Society, 20 Mahakali Caves Road, Andheri (E), Mumbai-400093<br>
                <i class="fas fa-map-marker-alt"></i> <strong>Regd. Office: </strong> 913, One World West, S. No. 396,
                FP 119, Village- Vejalpur, Ahmedabad, Gujarat, India<br>
                <i class="fas fa-phone"></i> +91 9924203751 / 9924243751
                <i class="fas fa-envelope"></i> export@specialitymedicine.com
                <i class="fas fa-globe"></i> www.specialitymedicine.com
            </p>
        </div>
    </footer>

    <!-- Wrap the content of your PDF inside a main tag -->
    <div class="bg-image"></div>
    <main>
   
        <div class="invoice-info">
            <strong>INVOICE NO :</strong>
            <span>{{ $order->invoice_no ?? '' }}</span><br>
            <strong>DATE :</strong>
            <span>
                @php
                use \Carbon\Carbon;
                @endphp
                {{ $order->invoice_date ? Carbon::parse($order->invoice_date)->format('d-m-Y') : '' }}
            </span>
        </div><br><br>
        <div class="bill-to">
            <strong>BILL TO:</strong><br>
            <span>{{ $order->bill_to_company_name ?? '' }}</span><br>
            <span>
                {{ $order->bill_to_address . ', ' . $order->bill_to_zip_code ?? ''}}
            </span><br>
            <span>{{ $order->bill_to_phone_no ?? ''}}</span><br>
            <span>{{ $order->bill_to_registration_no ?? ''}}</span>
        </div>
        <div class="ship-to">
            <strong>SHIP TO:</strong><br>
            <span class="text-left">TO THE ORDER,</span>
        </div><br><br><br><br>
        <table>
            <thead>
                <tr>
                    <th>QUANTITY</th>
                    <th>DESCRIPTION</th>
                    <th>UNIT PRICE {{ $order->currency }}</th>
                    <th>TOTAL {{ $order->currency }}</th>
                </tr>
            </thead>
            <tbody>
                @php
                $subTotal = calculateSubTotalValue($order);
                $totalValue = calculateTotalValue($order);
                $centValue = explode('.', number_format($totalValue, 2))[1];
                if ($centValue >= 50) {
                $totalValue = ceil($totalValue);
                }

                $totalShippingHandling = 0;
                $totalShippingHandling += $order->shipping;
                $totalShippingHandling += $order->soft_boxes;
                $totalShippingHandling += $order->data_logger;
                $totalShippingHandling += $order->clearance;

                $rowCount = 0;
                @endphp
                @foreach($order->orderProducts as $orderProduct)
                @php
                $rowCount++;
                $productName = '';
                $heading = '';
                $genericName = '';
                $manufacturedBy = '';
                $hsnCode = '';
                if ($orderProduct->product_id == $orderProduct->products->id) {
                $productName = $orderProduct->products->name;
                $heading = $orderProduct->products->heading;
                $genericName = $orderProduct->products->generic_name;
                $manufacturedBy = $orderProduct->products->manufactured_by;
                $hsnCode = $orderProduct->products->hsn_code;
                }
                if ($orderProduct->product_variant_id == $orderProduct->productVariants->id) {
                $packSize = $orderProduct->productVariants->name;
                }
                @endphp
                @if ($rowCount > 1 && $rowCount % 10 == 0)
                <tr class="page-break">
                    @else
                <tr>
                    @endif
                    <td>
                        <span>
                            {{ $orderProduct->quantity }}
                            {{ $orderProduct->quantity == 1 ? 'SET' : 'SETS' }}
                        </span><br>
                        <span>{{ '(' . $packSize . ')' }}</span>
                    </td>
                    <td>
                        <span>{{ $heading ?? ''}}</span><br>
                        <strong>{{ $genericName ?? ''}}</strong><br>
                        <span>MANUFACTURED BY: {{ $manufacturedBy ?? ''}}</span><br>
                        @foreach($orderProduct->orderProductStocks as $orderProductStock)
                        @php
                        $mfg_date = $orderProductStock->mfg_date ? DateTime::createFromFormat('Y-n',
                        $orderProductStock->mfg_date) : null;
                        $exp_date = $orderProductStock->exp_date ? DateTime::createFromFormat('Y-n',
                        $orderProductStock->exp_date) : null;
                        @endphp
                        <span>BATCH NO.{{ $orderProductStock->batch_no ?? '' }}, MFG
                            DATE:{{ $mfg_date ? $mfg_date->format('n/Y') : '' }}, EXP
                            DATE:{{ $exp_date ? $exp_date->format('n/Y') : '' }},
                            {{ $orderProductStock->quantity ? '(' . $orderProductStock->quantity . ' ' . ($orderProductStock->quantity > 1 ? 'SETS' : 'SET') . ')' : '' }}
                        </span><br>
                        @endforeach
                        <strong>{{ $productName ?? ''}}</strong><br>
                        <span>HSN CODE: {{ $hsnCode ?? ''}}</span>
                    </td>
                    <td>{{ $orderProduct->price_per_set ?? ''}}</td>
                    <td>{{ format_currency($orderProduct->total) ?? ''}}</td>
                </tr>
                @endforeach
                <tr>
                    <th colspan="3" class="flot-right">SUB TOTAL</th>
                    <td>{{ number_format($subTotal, 2) }}</td>
                </tr>
                <tr>
                    <th colspan="3" class="flot-right">ROUND OFF</th>
                    <td>
                        @if ($centValue === null || $centValue == 0)
                        {{ '0.00' }}
                        @elseif ($centValue >= 50)
                        {{ '0.' . (100 - $centValue) }}
                        @else
                        {{ '-0.' . abs($centValue) }}
                        @endif
                    </td>
                </tr>
                <tr>
                    <th colspan="3" class="flot-right">SHIPPING & HANDLING</th>
                    <td>{{ number_format($totalShippingHandling, 2) ?? '00' }}</td>
                </tr>
                <tr>
                    <th colspan="3" class="flot-right">TOTAL</th>
                    <td>{{ number_format($totalValue, 2) ?? '00'}}</td>
                </tr>
            </tbody>
        </table> 

        <span class="total-word">TOTAL <strong>{{ $order->currency }}</strong> IN FIGURE: 
            {{ \App\Helpers\NumberToWordsHelper::convert($totalValue ?? '') }} ONLY.</span><br><br>

        <div class="terms">
            <span><strong>PAYMENT TERMS: </strong>{{ $order->payment_terms ?? ''}}</span><br>
            <span><strong>DELIVERY BY: </strong>{{ $order->delivery_by ?? ''}}</span><br>
            <span><strong>DELIVERY TIME: </strong>{{ $order->delivery_time ?? ''}}</span><br>
            <span><strong>DELIVERY TERMS: </strong>{{ $order->delivery_terms ?? ''}}</span><br>
            <span><strong>BANK DETAILS: </strong> COMPANY NAME: {{ $bankDetails->account_name ?? '' }}, BANK NAME:
                {{ $bankDetails->name ?? ''}}, A/C NO: {{ $bankDetails->account_no ?? '' }},
                SWIFT CODE NO: {{ $bankDetails->swift_code_no ?? '' }}, IFS CODE: {{ $bankDetails->ifsc_code ?? ''}},
                BRANCH: {{ $bankDetails->branch ?? ''}}</span>
        </div>
        
    </main>
</body>

</html>