<?php

namespace App\Http\Controllers;

use Barryvdh\DomPDF\Facade\Pdf;
use App\Helpers\ImageHelper;
use Illuminate\Support\Facades\Log;
use App\Models\Order;
use App\Models\Customers;
use App\Models\Bank;
use App\Models\Proforma;


class PDFController extends Controller
{
    public function customInvoice($id)
    {
        $logoPath = public_path('assets/images/logo-invoice.png');
        $bgLogoPath = public_path('assets/images/smpl-logo.png');
        $imagePath = str_replace('\\', '/', $logoPath);
        $bgImagePath = str_replace('\\', '/', $bgLogoPath);
        try {
            $logoBase64 = ImageHelper::convertToBase64($imagePath);
            $bgLogoBase64 = ImageHelper::convertToBase64($bgImagePath);
        } catch (\Exception $e) {
            Log::error($e->getMessage());
            $logoBase64 = null;
            $bgLogoBase64 = null;
        }

        $order = Order::with([
            'orderProducts.orderProductStocks',
            'orderPackages.orderPackageProducts',
            'orderProducts.products',
            'orderProducts.productVariants'
        ])->findOrFail($id);

        $customer = Customers::findOrFail($order->bill_to_customer_id);
        $bankDetails = Bank::findOrFail($customer->bank_id);

        $data = [
            'logoBase64' => $logoBase64,
            'bgLogoBase64' => $bgLogoBase64,
            'order' => $order,
            'bankDetails' => $bankDetails
        ];

        $pdf = Pdf::loadView('pdf.customInvoice', $data);
        $pdf->setPaper('A4');
        // return $pdf->stream('invoice.pdf'); // For displaying the PDF in 
        return $pdf->download("{$order->invoice_no} Custom Invoice.pdf");
    }

    public function customerInvoice($id)
    {
        $logoPath = public_path('assets/images/logo-invoice.png');
        $bgLogoPath = public_path('assets/images/smpl-logo.png');
        $imagePath = str_replace('\\', '/', $logoPath);
        $bgImagePath = str_replace('\\', '/', $bgLogoPath);
        try {
            $logoBase64 = ImageHelper::convertToBase64($imagePath);
            $bgLogoBase64 = ImageHelper::convertToBase64($bgImagePath);
        } catch (\Exception $e) {
            Log::error($e->getMessage());
            $logoBase64 = null;
            $bgLogoBase64 = null;
        }

        $data = ['logoBase64' => $logoBase64, 'bgLogoBase64' => $bgLogoBase64];

        $order = Order::with([
            'orderProducts.orderProductStocks',
            'orderPackages.orderPackageProducts',
            'orderProducts.products',
            'orderProducts.productVariants'
        ])->findOrFail($id);

        $customer = Customers::findOrFail($order->bill_to_customer_id);
        $bankDetails = Bank::findOrFail($customer->bank_id);

        // Prepare data as an array
        $data = [
            'logoBase64' => $logoBase64,
            'bgLogoBase64' => $bgLogoBase64,
            'order' => $order,
            'bankDetails' => $bankDetails
        ];

        $pdf = Pdf::loadView('pdf.customerInvoice', $data);
        $pdf->setPaper('A4');
        // return $pdf->stream('pdf.customerInvoice'); // For displaying the PDF in the browser
        return $pdf->download("{$order->invoice_no} Customer Invoice.pdf");
    }

    public function customPacking($id)
    {
        $logoPath = public_path('assets/images/logo-invoice.png');
        $bgLogoPath = public_path('assets/images/smpl-logo.png');
        $imagePath = str_replace('\\', '/', $logoPath);
        $bgImagePath = str_replace('\\', '/', $bgLogoPath);
        try {
            $logoBase64 = ImageHelper::convertToBase64($imagePath);
            $bgLogoBase64 = ImageHelper::convertToBase64($bgImagePath);
        } catch (\Exception $e) {
            Log::error($e->getMessage());
            $logoBase64 = null;
            $bgLogoBase64 = null;
        }

        $data = ['logoBase64' => $logoBase64, 'bgLogoBase64' => $bgLogoBase64];

        $order = Order::with([
            'orderProducts.orderProductStocks',
            'orderPackages.orderPackageProducts',
            'orderProducts.products',
            'orderProducts.productVariants'
        ])->findOrFail($id);

        $customer = Customers::findOrFail($order->bill_to_customer_id);
        $bankDetails = Bank::findOrFail($customer->bank_id);

        // Prepare data as an array
        $data = [
            'logoBase64' => $logoBase64,
            'bgLogoBase64' => $bgLogoBase64,
            'order' => $order,
            'bankDetails' => $bankDetails
        ];

        $pdf = Pdf::loadView('pdf.customPacking', $data);
        $pdf->setPaper('A4');
        // return $pdf->stream('pdf.customPacking'); // For displaying the PDF in the browser
        return $pdf->download("{$order->invoice_no} Custom Packing list.pdf");
    }

    public function customerPacking($id)
    {
        $logoPath = public_path('assets/images/logo-invoice.png');
        $bgLogoPath = public_path('assets/images/smpl-logo.png');
        $imagePath = str_replace('\\', '/', $logoPath);
        $bgImagePath = str_replace('\\', '/', $bgLogoPath);
        try {
            $logoBase64 = ImageHelper::convertToBase64($imagePath);
            $bgLogoBase64 = ImageHelper::convertToBase64($bgImagePath);
        } catch (\Exception $e) {
            Log::error($e->getMessage());
            $logoBase64 = null;
            $bgLogoBase64 = null;
        }

        $data = ['logoBase64' => $logoBase64, 'bgLogoBase64' => $bgLogoBase64];

        $order = Order::with([
            'orderProducts.orderProductStocks',
            'orderPackages.orderPackageProducts',
            'orderProducts.products',
            'orderProducts.productVariants'
        ])->findOrFail($id);

        $customer = Customers::findOrFail($order->bill_to_customer_id);
        $bankDetails = Bank::findOrFail($customer->bank_id);

        // Prepare data as an array
        $data = [
            'logoBase64' => $logoBase64,
            'bgLogoBase64' => $bgLogoBase64,
            'order' => $order,
            'bankDetails' => $bankDetails
        ];

        $pdf = Pdf::loadView('pdf.customerPacking', $data);
        $pdf->setPaper('A4');
        // return $pdf->stream('pdf.customerPacking'); // For displaying the PDF in the browser
        return $pdf->download("{$order->invoice_no} Customer Packing list.pdf");
    }

    public function proformaInvoice($id)
    {
        $logoPath = public_path('assets/images/logo-invoice.png');
        $bgLogoPath = public_path('assets/images/smpl-logo.png');
        $imagePath = str_replace('\\', '/', $logoPath);
        $bgImagePath = str_replace('\\', '/', $bgLogoPath);
        try {
            $logoBase64 = ImageHelper::convertToBase64($imagePath);
            $bgLogoBase64 = ImageHelper::convertToBase64($bgImagePath);
        } catch (\Exception $e) {
            Log::error($e->getMessage());
            $logoBase64 = null;
            $bgLogoBase64 = null;
        }

        $proforma = Proforma::with([
            'proformaProducts.products',
            'proformaProducts.productVariants'
        ])->findOrFail($id);

        $customer = Customers::findOrFail($proforma->bill_to_customer_id);
        $bankDetails = Bank::findOrFail($customer->bank_id);

        $data = [
            'logoBase64' => $logoBase64,
            'bgLogoBase64' => $bgLogoBase64,
            'proforma' => $proforma,
            'bankDetails' => $bankDetails
        ];

        $pdf = Pdf::loadView('pdf.proformaInvoice', $data);
        $pdf->setPaper('A4');
        // return $pdf->stream('proformaInvoice.pdf'); // For displaying the PDF in 
        return $pdf->download("$proforma->invoice_no.pdf");
    }
}

