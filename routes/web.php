<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\HomeController;
use App\Http\Controllers\WelcomeController;
use App\Http\Controllers\UsersController;
use App\Http\Controllers\RoleController;
use App\Http\Controllers\OrderController;
use App\Http\Controllers\OrderProductController;
use App\Http\Controllers\OrderPurchaseController;
use App\Http\Controllers\OrderProductStockController;
use App\Http\Controllers\OrderPackageController;
use App\Http\Controllers\BillingController;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\CustomerController;
use App\Http\Controllers\BankController;
use App\Http\Controllers\PDFController;
use App\Http\Controllers\ProformaController;
use App\Http\Controllers\ProformaProductController;
use App\Http\Controllers\VenderController;
use App\Http\Controllers\GenericController;
use App\Http\Controllers\ManufacturerController;
use App\Http\Controllers\InquireController;
use App\Http\Controllers\QuotationController;
use App\Http\Controllers\NotificationController;
use App\Http\Controllers\UserDeviceTokenController;
use App\Http\Controllers\QuotationQueriesController;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

Auth::routes();

Route::group(['middleware' => ['auth', 'checkstatus']], function () {
    Route::get('/', [App\Http\Controllers\HomeController::class, 'index'])->name('home');

    Route::resource('roles', RoleController::class);
    Route::resource('users', UsersController::class);
    Route::resource('orders', OrderController::class);
    Route::resource('orderProducts', OrderProductController::class);
    Route::resource('orderPurchase', OrderPurchaseController::class);
    Route::resource('orderProductStock', OrderProductStockController::class);
    Route::resource('orderPackage', OrderPackageController::class);
    Route::resource('billing', BillingController::class);
    Route::resource('customers', CustomerController::class);
    Route::resource('products', ProductController::class);
    Route::resource('banks', BankController::class);
    Route::resource('proformas', ProformaController::class);
    Route::resource('proformaProducts', ProformaProductController::class);
    Route::resource('venders', VenderController::class);
    Route::resource('generics', GenericController::class);
    Route::resource('manufacturers', ManufacturerController::class);
    Route::resource('inquires', InquireController::class);
    Route::resource('quotations', QuotationController::class);

    Route::get('orders/{order}/editOrder', [OrderController::class, 'editOrder'])->name('orders.editOrder');
    Route::patch('orders/{id}/updateOrder', [OrderController::class, 'updateOrder'])->name('orders.updateOrder');
    Route::delete('/orderPackageProduct/{id}', [OrderPackageController::class, 'destroyPackageProduct'])->name('orderPackage.destroyPackageProduct');
    Route::get('users/{id}/resetPassword', [UsersController::class, 'resetPassword'])->name('users.resetPassword');
    Route::patch('users/{id}/updateResetPassword', [UsersController::class, 'updateResetPassword'])->name('users.updateResetPassword');
    Route::get('customers/{id}/editParent', [CustomerController::class, 'editParent'])->name('customers.editParent');
    Route::patch('customers/{id}/{parent_id}/updateParent', [CustomerController::class, 'updateParent'])->name('customers.updateParent');
    Route::delete('/customersParent/{id}', [CustomerController::class, 'parentDestroy'])->name('customers.parentDestroy');

    Route::get('/profile', 'App\Http\Controllers\DashboardController@profile')->name('profile');
    Route::post('/profile', 'App\Http\Controllers\DashboardController@profileupdate')->name('profile.update');
    Route::post('/changepassword', 'App\Http\Controllers\DashboardController@changepasswordupdate')->name('changepassword.update');
    Route::delete('/productsVariant/{id}', [ProductController::class, 'variantDestroy'])->name('products.variantDestroy');
    Route::put('/products/{id}/status', 'App\Http\Controllers\ProductController@updateStatus')->name('products.updateStatus');
    Route::post('/getShipTo', 'App\Http\Controllers\OrderController@getCustomerShipTo')->name('getShipTo');
    Route::post('/getBillTo', 'App\Http\Controllers\OrderController@getCustomerBillTo')->name('getBillTo');
    Route::post('/getShipToDetails', 'App\Http\Controllers\OrderController@getCustomerShipToDetails')->name('getShipToDetails');
    Route::post('/createCustomer', 'App\Http\Controllers\OrderController@createCustomer')->name('createCustomer.store');
    Route::get('/pdf/{id}/customInvoice', [PDFController::class, 'customInvoice'])->name('pdf.customInvoice');
    Route::get('/pdf/{id}/customerInvoice', [PDFController::class, 'customerInvoice'])->name('pdf.customerInvoice');
    Route::get('/pdf/{id}/customPacking', [PDFController::class, 'customPacking'])->name('pdf.customPacking');
    Route::get('/pdf/{id}/customerPacking', [PDFController::class, 'customerPacking'])->name('pdf.customerPacking');
    Route::post('/proformaToOrder','App\Http\Controllers\ProformaController@proformaToConvertOrder')->name('proformaToOrder');
    Route::get('/pdf/{id}/proformaInvoice', [PDFController::class, 'proformaInvoice'])->name('pdf.proformaInvoice');
    Route::post('/inquires/{id}/assignInquire','App\Http\Controllers\InquireController@assignInquire')->name('inquires.assignInquire');
    Route::delete('/productPhoto/{id}', [QuotationController::class, 'photoDestroy'])->name('quotations.photoDestroy');
    Route::delete('/productDocument/{id}', [QuotationController::class, 'documentDestroy'])->name('quotations.documentDestroy');
    Route::delete('/supplier/{id}', [QuotationController::class, 'supplierDestroy'])->name('quotations.supplierDestroy');
    Route::post('/inquires/{id}/close', [InquireController::class, 'close'])->name('inquires.close');
    Route::get('/inquires/{id}/showInquireHistory', [InquireController::class, 'showInquireHistory'])->name('inquires.showInquireHistory');
    Route::post('/user-device-token', [UserDeviceTokenController::class, 'store']);
    Route::get('/comments/{quotationId}', [QuotationQueriesController::class, 'index']);
    Route::post('/comments/{quotationId}', [QuotationQueriesController::class, 'store']);
    Route::get('/get-pack-sizes/{brandId}', [QuotationController::class, 'getPackSizes'])->name('get.pack.sizes');
    Route::get('/notifications/fetch', [NotificationController::class, 'fetch'])->name('notifications.fetch');
    Route::post('/notifications/mark-as-read', [NotificationController::class, 'markAsRead'])->name('notifications.markAsRead');
});