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
                page-break-after: always;
            }

            table {
                left: 2cm;
                width: 100%;
                border-collapse: collapse;
            }

            table,
            th,
            td {
                font-size: 10px;
                border: 1px solid black;
                padding-top: 2px;
                padding-left: 5px;
                text-align: left;
                vertical-align: text-top;
            }

            .total-word {
                font-size: 10px;
            }

            .flot-right {
                text-align: right;
            }

            .packing-list {
                font-size: 14px;
            }

            .terms {
                top: 1px;
                padding: 5px;
                font-size: 10px;
                border: 1px solid black;
            }

            .terms-condition {
                padding-left: 10px;
                font-size: 10px;
            }

            .bill-to {
                font-size: 10px;
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
                height: 100%;
                width: 2rem;
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

        <h2 class="heading">PACKING LIST</h2>

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
                <i class="fas fa-map-marker-alt"></i> <strong>Regd. Office: </strong>H-401, Silver Stroke Apart.
                Near-Govt. Tube Well, Bopal, Ahmedabad - 380 058, Gujarat, India<br>
                <i class="fas fa-phone"></i> +91 9924203751 / 9924243751
                <i class="fas fa-envelope"></i> export@specialitymedicine.com
                <i class="fas fa-globe"></i> www.specialitymedicine.com
            </p>
        </div>
    </footer>

    <!-- Wrap the content of your PDF inside a main tag -->
    <div class="bg-image"></div>
    <main>
        <br>
        <table>
            <tr>
                <td colspan="2">
                    <span><strong>SPECIALITY MEDICINES LIMITED</strong></span><br>
                    <span>GSTIN – 27ABFCS4085C1ZC</span><br>
                    <span>IEC – ABFCS4085C</span>
                </td>
                <td colspan="2" class="invoice">
                    <span><strong>INVOICE NO: </strong>{{ $order->invoice_no ?? '' }}</span><br>
                    <span>
                        <strong>DATE: </strong>
                        @php
                            use \Carbon\Carbon;
                        @endphp
                        {{ $order->invoice_date ? Carbon::parse($order->invoice_date)->format('d-m-Y') : '' }}
                    </span>
                </td>
                <td colspan="3" class="packing-list">
                    <strong>PACKING LIST</strong>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <strong>CONSIGNEE SHIP TO:</strong><br>
                    <div>
                        <span>{{ $order->ship_to_company_name ?? ''}}</span><br>
                        <span>{{ $order->ship_to_address . ',' . $order->ship_to_zip_code ?? ''}}</span><br>
                        <span>{{ $order->ship_to_phone_no ?? ''}}</span><br>
                        <span>{{ $order->ship_to_registration_no ?? ''}}</span>
                    </div>
                </td>
                <td colspan="2"></td>
                <td colspan="3">
                    <strong>BUYER OF OTHER</strong><br>
                    <span> {{ $order->bill_to_company_name ?? ''}}</span><br>
                    <span>{{ $order->bill_to_address . ',' . $order->bill_to_zip_code ?? ''}}</span><br>
                    <span>{{ $order->bill_to_phone_no ?? ''}}</span><br>
                    <span>{{ $order->bill_to_registration_no ?? ''}}</span>
                </td>
            </tr>
            <tr>
                <th colspan="2">PRE CARRIAGE NO.</th>
                <th colspan="2">PLACE OF REPLACEMENT PRE</th>
                <th>COUNTRY OF ORIGIN OF GOODS</th>
                <th colspan="2">COUNTRY OF FINAL DESTINATIONS</th>
            </tr>
            <tr>
                <th colspan="2">VESSEL/ FLIGHT NO.</th>
                <th colspan="2">PORT OF LOADING:</th>
                <td>INDIA</td>
                <td colspan="2">{{ $order->country ?? '' }}</td>
            </tr>
            <tr>
                <td colspan="2">BY AIR</td>
                <td colspan="2" style="word-wrap: break-word;">{{ $order->delivery_by ?? '' }}</td>
                <td colspan="3" style="word-wrap: break-word;"><strong>TERMS OF DELIVERY AND PAYMENT: </strong>{{ $order->delivery_terms ?? '' }}
                    {{ $order->payment_terms ?? '' }}</td>
            </tr>
            <tr>
                <th colspan="2">PORT OF DISCHARGE:</th>
                <th colspan="2">FINAL DESTINATION:</th>
                <td rowspan="2" colspan="3">IMMEDIATE DISPATCH</td>
            </tr>
            <tr>
                <td colspan="2" style="word-wrap: break-word;">{{ $order->port_of_discharge ?? '' }}</td>
                <td colspan="2">{{ $order->country ?? '' }}</td>
            </tr>
            <thead>
                <tr>
                    <th colspan="2">NO. & KIND OF PACKING</th>
                    <th rowspan="3">DESCRIPTION OF GOODS</th>
                    <th rowspan="3">QUANTITY (SETS)</th>
                    <th rowspan="3">GROSS WEIGHT (KGS)</th>
                    <th rowspan="3">NET WEIGHT (KGS)</th>
                    <th rowspan="3">BOX SIZE (CM)</th>
                </tr>
                <tr>
                    <th></th>
                    <th>MARKS</th>
                </tr>
                <tr>
                    <th>S/N#</th>
                    <th>BOXES</th>
                </tr>
            </thead>
            <tbody>
                @php
                    $totalQuantity = 0;
                    $totalGrossWeight = 0;
                    $totalNetWeight = 0;
                    $serialNumber = 1;
                    $totalBoxes = 0;
                    $rowCount = 0;
                @endphp
                @foreach($order->orderPackages as $packageIndex => $orderPackage)
                    @php
                        $numPackageProducts = count($orderPackage->orderPackageProducts);
                        $totalGrossWeight += $orderPackage->gross_weight;
                        $totalNetWeight += $orderPackage->net_weight;
                        if ($numPackageProducts > 0) {
                            $totalBoxes++;
                        }
                    @endphp
                    @if ($numPackageProducts > 0)
                        @foreach ($orderPackage->orderPackageProducts as $packageProductIndex => $packageProduct)
                            @php            $rowCount++; @endphp 
                            @if ($rowCount > 1 && $rowCount % 15 == 0)
                                <tr class="page-break">
                            @else
                                <tr>
                            @endif
                                @if ($packageProductIndex == 0)
                                    <td rowspan="{{ $numPackageProducts }}">{{ $serialNumber }}</td>
                                    <td rowspan="{{ $numPackageProducts }}">{{ $orderPackage->box_no }}</td>
                                @endif
                                @php
                                    $totalQuantity += $packageProduct->quantity;
                                    $productName = '';
                                    foreach ($order->orderProducts as $orderProduct) {
                                        if ($orderProduct->id == $packageProduct->order_product_id) {
                                            $product = $orderProduct->products->firstWhere('id', $orderProduct->product_id);
                                            if ($product) {
                                                $productName = $product->name;
                                                break;
                                            }
                                        }
                                    }
                                @endphp
                                <td>{{ $productName }}</td>
                                <td>{{ $packageProduct->quantity }}</td>
                                @if ($packageProductIndex == 0)
                                    <td rowspan="{{ $numPackageProducts }}">{{ $orderPackage->gross_weight }}</td>
                                    <td rowspan="{{ $numPackageProducts }}">{{ $orderPackage->net_weight }}</td>
                                    <td rowspan="{{ $numPackageProducts }}">{{ $orderPackage->dimension . ' CMS' }}</td>
                                @endif
                            </tr>
                            @php
                                if ($packageProductIndex == 0) {
                                    $serialNumber++;
                                }
                            @endphp
                        @endforeach
                    @endif
                @endforeach
                <tr>
                    <td>TOTAL BOX: {{ $totalBoxes }}</td>
                    <td></td>
                    <td></td>
                    <td>TOTAL: {{ number_format($totalQuantity, 0) }} SETS</td>
                    <td>GROSS WEIGHT: {{ $totalGrossWeight }} KGS</td>
                    <td>NET WEIGHT: {{ $totalNetWeight }} KGS</td>
                    <td></td>
                </tr>
            </tbody>
        </table>
    </main>
</body>


</html>