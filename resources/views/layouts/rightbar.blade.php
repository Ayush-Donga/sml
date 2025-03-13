<div class="rightbar">
    <!-- Start Topbar Mobile -->
    <div class="topbar-mobile">
        <div class="row align-items-center">
            <div class="col-md-12">
                <div class="mobile-logobar">
                    <a href="{{url('/')}}" class="mobile-logo"><img src="{{ asset('assets/images/smpl-logo.png') }}" class="img-fluid" alt="logo"></a>
                </div>
                <div class="mobile-togglebar">
                    <ul class="list-inline mb-0">
                        <li class="list-inline-item">
                            <div class="topbar-toggle-icon">
                                <a class="topbar-toggle-hamburger" href="javascript:void();">
                                    <img src="{{ asset('assets/images/svg-icon/horizontal.svg') }}" class="img-fluid menu-hamburger-horizontal" alt="horizontal">
                                    <img src="{{ asset('assets/images/svg-icon/verticle.svg') }}" class="img-fluid menu-hamburger-vertical" alt="verticle">
                                 </a>
                             </div>
                        </li>
                        <li class="list-inline-item">
                            <div class="menubar">
                                <a class="menu-hamburger" href="javascript:void();">
                                    <img src="{{ asset('assets/images/svg-icon/collapse.svg') }}" class="img-fluid menu-hamburger-collapse" alt="collapse">
                                    <img src="{{ asset('assets/images/svg-icon/close.svg') }}" class="img-fluid menu-hamburger-close" alt="close">
                                 </a>
                             </div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <!-- Start Topbar -->
    <div class="topbar">
        <!-- Start row -->
        <div class="row align-items-center">
            <!-- Start col -->
            <div class="col-md-12 align-self-center">
                <div class="togglebar">
                    <ul class="list-inline mb-0">
                        <li class="list-inline-item">
                            <div class="menubar">
                                <a class="menu-hamburger" href="javascript:void();">
                                   <img src="{{ asset('assets/images/svg-icon/collapse.svg') }}" class="img-fluid menu-hamburger-collapse" alt="collapse">
                                   <img src="{{ asset('assets/images/svg-icon/close.svg') }}" class="img-fluid menu-hamburger-close" alt="close">
                                 </a>
                             </div>
                        </li>
                    </ul>
                </div>
                @php
                    use Carbon\Carbon;
                @endphp
                @php
                    $user = Auth::user();
                    $allNotifications = \App\Models\Notification::where('user_id', $user->id)
                    ->whereDate('created_at', '>=', \Carbon\Carbon::now()->subDays(30)->toDateString())
                    ->latest()
                    ->get();
                    $unreadNotifications = $allNotifications->where('is_read', false);
                    $readNotifications = $allNotifications->where('is_read', true);
                    $unreadCount = $unreadNotifications->count();
                @endphp
                <div class="infobar">
                    <ul class="list-inline mb-0 pt-2">
                        <li class="list-inline-item">
                            <div class="profilebar">
                                    @guest
                                        @if (Route::has('login'))
                                            <li class="nav-item">
                                                <a class="nav-link" href="{{ route('login') }}">{{ __('Login') }}</a>
                                            </li>
                                        @endif

                                        @if (Route::has('register'))
                                            <li class="nav-item">
                                                <a class="nav-link" href="{{ route('register') }}">{{ __('Register') }}</a>
                                            </li>
                                        @endif
                                    @else
                                        <div class="dropdown">
                                        <a class="dropdown-toggle" href="#" role="button" id="profilelink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><img src="{{ asset('assets/images/users/profile.svg') }}" class="img-fluid" alt="profile"><span class="feather icon-chevron-down live-icon"></span></a>
                                            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="profilelink">
                                                <div class="dropdown-item">
                                                    <div class="profilename">
                                                    <h5>{{ Auth::user()->name }}</h5>
                                                    </div>
                                                </div>
                                                <div class="userbox">
                                                    <ul class="list-unstyled mb-0">
                                                        <li class="media dropdown-item">
                                                            <a href="{{ url('profile') }}" class="profile-icon"><img src="{{ asset('assets/images/svg-icon/user.svg') }}" class="img-fluid" alt="user">My Profile</a>
                                                        </li>
                                                        <li class="media dropdown-item">
                                                            <a href="{{ route('logout') }}"
                                                                onclick="event.preventDefault();
                                                                document.getElementById('logout-form').submit();" class="profile-icon"><img src="{{ asset('assets/images/svg-icon/logout.svg') }}" class="img-fluid" alt="logout">Logout</a>

                                                            <form id="logout-form" action="{{ route('logout') }}" method="POST" class="d-none">
                                                                @csrf
                                                            </form>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                    @endguest
                            </div>
                        </li>

                      <!-- Notification Icon -->
                      <li class="list-inline-item">
                            <div class="dropdown" data-bs-auto-close="outside">
                                <a class="dropdown-toggle" href="#" id="notificationIcon" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="img-fluid" fill="currentColor" viewBox="0 0 16 16" alt="notifications" style="width: 22px; height: 22px; margin-top: -10px;">
                                        <path d="M8 16a2 2 0 0 0 2-2H6a2 2 0 0 0 2 2zm.86-14.022A5.002 5.002 0 0 1 13 7c0 1.098.072 1.844.361 2.469.215.466.318.711.318 1.078 0 .54-.378.922-.904.922H3.224c-.526 0-.904-.382-.904-.922 0-.367.103-.612.318-1.078C2.928 8.844 3 8.098 3 7a5.002 5.002 0 0 1 4.14-4.978.5.5 0 0 1 .72 0zM14 7a6 6 0 1 0-12 0c0 1.06-.072 1.908-.398 2.596-.234.508-.602 1.036-.602 1.904 0 1.24.936 2.422 2.224 2.422h9.552c1.288 0 2.224-1.182 2.224-2.422 0-.868-.368-1.396-.602-1.904C14.072 8.908 14 8.06 14 7z"/>
                                    </svg>
                                    <span class="badge badge-danger notification-count">{{ $unreadCount > 0 ? $unreadCount : '' }}</span>
                                </a>
                                <div class="dropdown-menu dropdown-menu-right p-3" aria-labelledby="notificationIcon" style="width: 300px;">
                                    <h6 class="dropdown-header">Notifications</h6>
                                    <ul class="nav nav-tabs" id="notificationTabs" role="tablist">
                                        <li class="nav-item">
                                            <a class="nav-link active" id="unread-tab" data-toggle="tab" href="#unread" role="tab" aria-controls="unread" aria-selected="true">Unread</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" id="read-tab" data-toggle="tab" href="#read" role="tab" aria-controls="read" aria-selected="false">Read</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" id="all-tab" data-toggle="tab" href="#all" role="tab" aria-controls="all" aria-selected="false">All</a>
                                        </li>
                                    </ul>
                                    <div class="tab-content" id="notificationTabsContent">
                                        <!-- Unread Notifications -->
                                        <div class="tab-pane fade show active notification-list" id="unread" role="tabpanel" aria-labelledby="unread-tab">
                                            @foreach ($unreadNotifications as $notification)
                                                <a href="{{ $notification->url }}" data-id="{{ $notification->id }}" class="dropdown-item unread" target="_blank">
                                                    <strong>{{ $notification->heading }}</strong>
                                                    <p class="mb-0 font-weight-normal">{{ $notification->content }}</p>
                                                    @php
                                                        $formattedDate = $notification->created_at->setTimezone('Asia/Kolkata')->format('D d M, Y, h:i A');
                                                        $timeLabel = $notification->created_at->isToday() 
                                                            ? 'Today' 
                                                            : ($notification->created_at->isYesterday() ? 'Yesterday' : '');
                                                        $displayDate = $timeLabel ? $timeLabel . ' ' . $formattedDate : $formattedDate;
                                                    @endphp
                                                    <small class="text-muted">{{ $displayDate }}</small>
                                                </a>
                                            @endforeach
                                        </div>
                                        <!-- Read Notifications -->
                                        <div class="tab-pane fade notification-list" id="read" role="tabpanel" aria-labelledby="read-tab">
                                            @foreach ($readNotifications as $notification)
                                                <a href="{{ $notification->url }}" data-id="{{ $notification->id }}" class="dropdown-item read" target="_blank">
                                                    <strong>{{ $notification->heading }}</strong>
                                                    <p class="mb-0 font-weight-normal">{{ $notification->content }}</p>
                                                    @php
                                                        $formattedDate = $notification->created_at->setTimezone('Asia/Kolkata')->format('D d M, Y, h:i A');
                                                        $timeLabel = $notification->created_at->isToday() 
                                                            ? 'Today' 
                                                            : ($notification->created_at->isYesterday() ? 'Yesterday' : '');
                                                        $displayDate = $timeLabel ? $timeLabel . ' ' . $formattedDate : $formattedDate;
                                                    @endphp
                                                    <small class="text-muted">{{ $displayDate }}</small>
                                                </a>
                                            @endforeach
                                        </div>
                                        <!-- All Notifications -->
                                        <div class="tab-pane fade notification-list" id="all" role="tabpanel" aria-labelledby="all-tab">
                                            @foreach ($allNotifications as $notification)
                                                <a href="{{ $notification->url }}" data-id="{{ $notification->id }}" class="dropdown-item {{ $notification->is_read ? 'read' : 'unread' }}" target="_blank">
                                                    <strong>{{ $notification->heading }}</strong>
                                                    <p class="mb-0 font-weight-normal">{{ $notification->content }}</p>
                                                    @php
                                                        $formattedDate = $notification->created_at->setTimezone('Asia/Kolkata')->format('D d M, Y, h:i A');
                                                        $timeLabel = $notification->created_at->isToday() 
                                                            ? 'Today' 
                                                            : ($notification->created_at->isYesterday() ? 'Yesterday' : '');
                                                        $displayDate = $timeLabel ? $timeLabel . ' ' . $formattedDate : $formattedDate;
                                                    @endphp
                                                    <small class="text-muted">{{ $displayDate }}</small>
                                                </a>
                                            @endforeach
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
            <!-- End col -->
        </div>
        <!-- End row -->
    </div>
    <!-- End Topbar -->
     <script>
        document.addEventListener('DOMContentLoaded', function () {
            const NOTIFICATION_KEY = 'unreadCount';

            // Initial fetch to update notifications
            fetchNotifications();

            // Periodically fetch notifications every 10 seconds
            setInterval(fetchNotifications, 10000);

            // Sync unread count across tabs
            window.addEventListener('storage', function (event) {
                if (event.key === NOTIFICATION_KEY) {
                    updateNotificationCount(parseInt(event.newValue || 0));
                }
            });

            // Fetch notifications when the tab becomes active
            document.addEventListener('visibilitychange', function () {
                if (document.visibilityState === 'visible') {
                    fetchNotifications();
                }
            });

            // Fetch notifications from the server
            function fetchNotifications() {
                fetch('{{ route("notifications.fetch") }}')
                    .then(response => response.json())
                    .then(data => {
                        const unreadCount = data.unreadCount || 0;
                        updateNotificationDropdown(data);
                        updateNotificationCount(unreadCount);
                        // Sync count across all tabs
                        localStorage.setItem(NOTIFICATION_KEY, unreadCount);
                    })
                    .catch(error => console.error('Error fetching notifications:', error));
            }

            // Update the notification dropdown
            function updateNotificationDropdown(data) {
                updateNotificationList('unread', data.unreadNotifications);
                updateNotificationList('read', data.readNotifications);
                updateNotificationList('all', data.allNotifications);
            }

            // Update the notification count badge
            function updateNotificationCount(count) {
                const notificationCountElement = document.querySelector('.notification-count');
                notificationCountElement.textContent = count > 0 ? count : '';
            }

            // Mark a notification as read
            document.body.addEventListener('click', function (event) {
                if (event.target.closest('.dropdown-item')) {
                    const link = event.target.closest('.dropdown-item');
                    const notificationId = link.getAttribute('data-id');

                    fetch('{{ route("notifications.markAsRead") }}', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json',
                            'X-CSRF-TOKEN': '{{ csrf_token() }}'
                        },
                        body: JSON.stringify({ id: notificationId })
                    })
                    .then(response => response.json())
                    .then(data => {
                        if (data.status === 'success') {
                            link.classList.remove('unread');
                            link.classList.add('read');
                            updateNotificationCount(data.unreadCount || 0);
                            // Sync count across all tabs
                            localStorage.setItem(NOTIFICATION_KEY, data.unreadCount || 0);
                        } else {
                            console.error(data.message);
                        }
                    })
                    .catch(error => console.error('Error:', error));
                }
            });

            // Helper function to update notification list
            function updateNotificationList(type, notifications) {
                const container = document.querySelector(`#${type}`);
                container.innerHTML = '';

                notifications.forEach(notification => {
                    const timeLabel = getTimeLabel(notification.created_at);
                    const notificationItem = `
                        <a href="${notification.url}" data-id="${notification.id}" class="dropdown-item ${notification.is_read ? 'read' : 'unread'}" target="_blank">
                            <strong>${notification.heading}</strong>
                            <p class="mb-0 font-weight-normal">${notification.content}</p>
                            <small class="text-muted">${timeLabel}</small>
                        </a>
                    `;
                    container.insertAdjacentHTML('beforeend', notificationItem);
                });
            }

            // Helper function to format time
            function getTimeLabel(createdAt) {
                const date = new Date(createdAt);
                const now = new Date();

                if (date.toDateString() === now.toDateString()) {
                    return `Today ${date.toLocaleTimeString('en-IN', { hour: '2-digit', minute: '2-digit' })}`;
                } else if (date.toDateString() === new Date(now.setDate(now.getDate() - 1)).toDateString()) {
                    return `Yesterday ${date.toLocaleTimeString('en-IN', { hour: '2-digit', minute: '2-digit' })}`;
                } else {
                    return date.toLocaleString('en-IN', { weekday: 'short', day: '2-digit', month: 'short', year: 'numeric', hour: '2-digit', minute: '2-digit' });
                }
            }
        });
     </script>
    <script> 
        document.addEventListener('DOMContentLoaded', function () {
            // Prevent dropdown from closing when interacting with tabs
            document.querySelectorAll('.dropdown-menu .nav-link').forEach(function (tab) {
                tab.addEventListener('click', function (event) {
                    event.stopPropagation(); // Prevent click event from propagating to the dropdown
                });
            });
        });
    </script>
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const dropdownMenu = document.querySelector('.dropdown-menu');

            // Prevent dropdown from closing when interacting inside it
            dropdownMenu.addEventListener('click', (e) => {
                e.stopPropagation();
            });

            // Handle tab switching inside the dropdown without closing it
            const tabs = document.querySelectorAll('#notificationTabs .nav-link');
            const tabContent = document.querySelectorAll('.tab-pane');

            tabs.forEach(tab => {
                tab.addEventListener('click', function (e) {
                    e.preventDefault();
                    tabs.forEach(t => t.classList.remove('active'));
                    tabContent.forEach(c => c.classList.remove('show', 'active'));
                    this.classList.add('active');
                    const target = document.querySelector(this.getAttribute('href'));
                    target.classList.add('show', 'active');
                });
            });

            // Close dropdown only when clicking outside it
            document.addEventListener('click', (event) => {
                const dropdown = document.querySelector('.dropdown');
                if (!dropdown.contains(event.target)) {
                    const dropdownToggle = dropdown.querySelector('[data-toggle="dropdown"]');
                    if (dropdownToggle && dropdown.classList.contains('show')) {
                        dropdownToggle.click(); // Manually close the dropdown
                    }
                }
            });
        });
    </script>
    @yield('breadcrumbbar')
    @yield('errormessege')

    @yield('rightbar-content')
    <!-- Start Footerbar -->
    <div class="footerbar">
        <footer class="footer">
            <p class="mb-0">© 2025 SMPL OutSource- All Rights Reserved.</p>
        </footer>
    </div>
    <!-- End Footerbar -->
</div>
