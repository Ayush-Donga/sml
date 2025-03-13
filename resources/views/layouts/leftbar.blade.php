<div class="leftbar">
    <!-- Start Sidebar -->
    <div class="sidebar">
        <!-- Start Logobar -->
        <div class="logobar">
            <a href="{{url('/')}}" class="logo logo-large"><img src="{{ asset('assets/images/smpl-logo.png') }}" class="img-fluid" alt="logo"></a>
        </div>
        <!-- End Logobar -->
        <!-- Start Navigationbar -->
        <div class="navigationbar">
            <ul class="vertical-menu">
                <li>
                    <a href="{{url('/')}}">
                      <img src="{{ asset('assets/images/svg-icon/dashboard.svg') }}" class="img-fluid" alt="dashboard"><span>Dashboard</span>
                    </a>
                </li>
                <li>
                    <a href="javaScript:void();">
                        <img src="{{ asset('assets/images/svg-icon/basic.svg') }}" class="img-fluid" alt="basic"><span>Users </span><i class="feather icon-chevron-right pull-right"></i>
                    </a>
                    @can('user-list')
                    <ul class="vertical-submenu">
                        <li><a href="{{url('/users')}}" class="vertical-submenu-a module-switch">User</a></li>
                    </ul>
                    @endcan
                    @can('role-list')
                    <ul class="vertical-submenu">
                        <li><a href="{{url('/roles')}}" class="vertical-submenu-a module-switch">Roles</a></li>
                    </ul>
                    @endcan
                </li>
               
                <li>
                    <a href="javaScript:void();">
                        <img src="{{ asset('assets/images/svg-icon/advanced.svg') }}" class="img-fluid" alt="advanced"><span>Master</span><i class="feather icon-chevron-right pull-right"></i>
                    </a>
                    @can('customer-list')
                        <ul class="vertical-submenu">
                            <li><a href="{{url('/customers')}}" class="vertical-submenu-a">Customers</a></li>
                        </ul>
                    @endcan
                    @can('product-list')
                        <ul class="vertical-submenu">
                            <li><a href="{{url('/products')}}" class="vertical-submenu-a">Products</a></li>
                        </ul>
                    @endcan
                    @can('bank-list')
                        <ul class="vertical-submenu">
                            <li><a href="{{url('/banks')}}" class="vertical-submenu-a">Banks</a></li>
                        </ul>
                    @endcan
                    @can('vender-list')
                        <ul class="vertical-submenu">
                            <li><a href="{{url('/venders')}}" class="vertical-submenu-a">Venders</a></li>
                        </ul>
                    @endcan
                    @can('generic-list')
                        <ul class="vertical-submenu">
                            <li><a href="{{url('/generics')}}" class="vertical-submenu-a">Generics</a></li>
                        </ul>
                    @endcan
                    @can('manufacturer-list')
                        <ul class="vertical-submenu">
                            <li><a href="{{url('/manufacturers')}}" class="vertical-submenu-a">Manufacturers</a></li>
                        </ul>
                    @endcan
                </li>

                <li>
                    <a href="javaScript:void();">
                        <img src="{{ asset('assets/images/svg-icon/advanced.svg') }}" class="img-fluid" alt="advanced"><span>Inquire Management</span><i class="feather icon-chevron-right pull-right"></i>
                    </a>
                        @can('inquire-list')
                            <ul class="vertical-submenu">
                                <li><a href="{{url('/inquires')}}" class="vertical-submenu-a">Inquires</a></li>
                            </ul>
                        @endcan
                        @can('quotation-list')
                        <ul class="vertical-submenu">
                            <li><a href="{{url('/quotations')}}" class="vertical-submenu-a">Quotations</a></li>
                        </ul>
                        @endcan
                </li>
                
                <li>
                    <a href="javaScript:void();">
                        <img src="{{ asset('assets/images/svg-icon/advanced.svg') }}" class="img-fluid" alt="advanced"><span>Order Management</span><i class="feather icon-chevron-right pull-right"></i>
                    </a>
                    @can('proforma-list')
                        <ul class="vertical-submenu">
                            <li><a href="{{url('/proformas')}}" class="vertical-submenu-a">Proforma Invoice</a></li>
                        </ul>
                    @endcan
                    @can('order-list')
                        <ul class="vertical-submenu">
                            <li><a href="{{url('/orders')}}" class="vertical-submenu-a">Orders</a></li>
                        </ul>
                    @endcan
                </li>
               
            </ul>
        </div>
        <!-- End Navigationbar -->
    </div>
    <!-- End Sidebar -->
</div>
