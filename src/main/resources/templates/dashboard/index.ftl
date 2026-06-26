<#ftl output_format="HTML">
<!DOCTYPE html>
<html lang="en">
<head>
  <#include "/layouts/head.ftl">
  <title>${setting.name!"KotlinAdmin"} - Dashboard</title>
</head>
<body class="bg-gray-100">
<div class="flex h-screen overflow-hidden">
  <aside class="hidden md:block w-64 sidebar-gradient fixed h-full overflow-y-auto z-20">
    <#include "/layouts/sidebar.ftl">
  </aside>
  <div class="flex-1 md:ml-64 flex flex-col min-h-screen overflow-y-auto">
    <header class="tw-card sticky top-0 z-10 rounded-none border-x-0 border-t-0">
      <#include "/layouts/topbar.ftl">
    </header>
    <main class="flex-1 p-6">
      <div class="mb-6">
        <h1 class="text-2xl font-bold text-gray-800">Dashboard Overview</h1>
        <p class="text-gray-500 text-sm mt-1">
          Welcome back, <strong>${(user.name)!"Admin"}</strong>! — ${currentDate!""}
        </p>
      </div>

      <#-- 4 Stat Cards -->
      <div class="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-4 gap-4 mb-6">
        <div class="tw-card p-6">
          <div class="flex items-center justify-between">
            <div>
              <p class="text-gray-500 text-sm">Total Users</p>
              <p class="text-3xl font-bold counter" data-target="${(stats.totalUsers)!0}"
                 style="color:var(--primary)">0</p>
            </div>
            <div class="rounded-full p-3" style="background:var(--theme-light)">
              <i class="fas fa-users fa-2x" style="color:var(--primary)"></i>
            </div>
          </div>
        </div>
        <div class="tw-card p-6">
          <div class="flex items-center justify-between">
            <div>
              <p class="text-gray-500 text-sm">Total Roles</p>
              <p class="text-3xl font-bold counter" data-target="${(stats.totalRoles)!0}"
                 style="color:var(--primary)">0</p>
            </div>
            <div class="rounded-full p-3" style="background:var(--theme-light)">
              <i class="fas fa-user-shield fa-2x" style="color:var(--primary)"></i>
            </div>
          </div>
        </div>
        <div class="tw-card p-6">
          <div class="flex items-center justify-between">
            <div>
              <p class="text-gray-500 text-sm">Total Permissions</p>
              <p class="text-3xl font-bold counter" data-target="${(stats.totalPermissions)!0}"
                 style="color:var(--primary)">0</p>
            </div>
            <div class="rounded-full p-3" style="background:var(--theme-light)">
              <i class="fas fa-key fa-2x" style="color:var(--primary)"></i>
            </div>
          </div>
        </div>
        <div class="tw-card p-6">
          <div class="flex items-center justify-between">
            <div>
              <p class="text-gray-500 text-sm">Active Theme</p>
              <p class="text-xl font-bold mt-1" style="color:var(--primary)">${themeName!"Blue"}</p>
            </div>
            <div class="rounded-full p-3" style="background:var(--theme-light)">
              <i class="fas fa-palette fa-2x" style="color:var(--primary)"></i>
            </div>
          </div>
        </div>
      </div>

      <#-- Charts -->
      <div class="grid grid-cols-1 lg:grid-cols-3 gap-4 mb-6">
        <div class="lg:col-span-2 tw-card p-6">
          <h3 class="font-semibold text-gray-700 mb-4">Monthly Users</h3>
          <canvas id="lineChart" height="100"></canvas>
        </div>
        <div class="tw-card p-6">
          <h3 class="font-semibold text-gray-700 mb-4">Distribution</h3>
          <canvas id="doughnutChart" height="200"></canvas>
          <div class="mt-4 space-y-2 text-sm">
            <div class="flex items-center gap-2">
              <span class="w-3 h-3 rounded-full" style="background:var(--primary)"></span> Active
            </div>
            <div class="flex items-center gap-2">
              <span class="w-3 h-3 rounded-full" style="background:var(--secondary)"></span> Inactive
            </div>
          </div>
        </div>
      </div>

      <#-- Recent Activities -->
      <div class="tw-card p-6 mb-6">
        <h3 class="font-semibold text-gray-700 mb-4">Recent Activities</h3>
        <div class="space-y-3">
          <div class="flex items-start gap-3 py-2 border-b border-gray-100">
            <div class="w-8 h-8 rounded-full flex items-center justify-center" style="background:var(--theme-light)">
              <i class="fas fa-user-plus text-xs" style="color:var(--primary)"></i>
            </div>
            <div>
              <p class="text-sm font-medium text-gray-700">New user registered</p>
              <p class="text-xs text-gray-400">Just now</p>
            </div>
          </div>
          <div class="flex items-start gap-3 py-2 border-b border-gray-100">
            <div class="w-8 h-8 rounded-full flex items-center justify-center" style="background:var(--theme-light)">
              <i class="fas fa-cog text-xs" style="color:var(--primary)"></i>
            </div>
            <div>
              <p class="text-sm font-medium text-gray-700">Settings updated</p>
              <p class="text-xs text-gray-400">5 minutes ago</p>
            </div>
          </div>
          <div class="flex items-start gap-3 py-2">
            <div class="w-8 h-8 rounded-full flex items-center justify-center" style="background:var(--theme-light)">
              <i class="fas fa-shield-alt text-xs" style="color:var(--primary)"></i>
            </div>
            <div>
              <p class="text-sm font-medium text-gray-700">Permission synced</p>
              <p class="text-xs text-gray-400">10 minutes ago</p>
            </div>
          </div>
        </div>
      </div>

      <#-- Recent Orders Data Table -->
      <div class="tw-card p-0 overflow-hidden mb-6">
        <div class="px-6 py-4 border-b flex items-center justify-between">
          <h3 class="font-semibold text-gray-700" style="color:var(--primary)">Recent Orders</h3>
          <span class="badge text-bg-primary">Latest</span>
        </div>
        <div class="p-4" style="overflow-x:auto">
          <table class="table table-bordered table-hover align-middle">
            <thead>
              <tr>
                <th></th>
                <th>
                  <form id="dash-search" method="GET">
                    <select name="q_page_size" class="form-control form-control" style="min-width:70px" onchange="this.form.submit()">
                      <option value="10">10</option>
                      <option value="20">20</option>
                    </select>
                  </form>
                </th>
                <th><input type="text" form="dash-search" name="q_order" placeholder="Order ID" class="form-control" style="min-width:100px"></th>
                <th><input type="text" form="dash-search" name="q_customer" placeholder="Customer" class="form-control" style="min-width:100px"></th>
                <th>
                  <div class="btn-group">
                    <button form="dash-search" class="btn btn-sm btn-success"><i class="fas fa-search"></i></button>
                    <a href="/admin/v1/dashboard" class="btn btn-sm btn-danger"><i class="fas fa-times"></i></a>
                  </div>
                </th>
              </tr>
              <tr>
                <th><input type="checkbox" id="checkall"></th>
                <th>No</th>
                <th>Order ID</th>
                <th>Customer</th>
                <th>Amount</th>
                <th>Status</th>
                <th>Action</th>
              </tr>
            </thead>
            <tbody>
              <form id="dash-selection" method="POST">
                <input type="hidden" name="_csrf" value="${_csrf}">
              </form>
              <tr>
                <td><input type="checkbox" form="dash-selection" name="selected[]" value="1"></td>
                <td>1</td>
                <td><span class="font-mono text-xs">#ORD-0001</span></td>
                <td>Sample Customer</td>
                <td>$99.00</td>
                <td><i class="fas fa-check-circle text-green-500 text-xl"></i></td>
                <td>
                  <div class="btn-group">
                    <button class="btn btn-sm btn-primary dropdown-toggle" data-toggle-dd>Action</button>
                    <div class="dropdown-menu dropdown-menu-end">
                      <a class="dropdown-item" href="#"><i class="fas fa-eye"></i> View</a>
                    </div>
                  </div>
                </td>
              </tr>
            </tbody>
          </table>
          <nav class="mt-4"><ul class="pagination">
            <li class="page-item disabled"><a class="page-link" href="#">Previous</a></li>
            <li class="page-item active"><a class="page-link" href="#">1</a></li>
            <li class="page-item disabled"><a class="page-link" href="#">Next</a></li>
          </ul></nav>
        </div>
      </div>
    </main>
  </div>
</div>
<#include "/layouts/foot.ftl">
<script>
// Counter animation
document.querySelectorAll('.counter').forEach(function(el) {
  var target = parseInt(el.dataset.target) || 0;
  var duration = 1000, step = target / (duration / 16);
  var current = 0;
  var timer = setInterval(function() {
    current += step;
    if (current >= target) { current = target; clearInterval(timer); }
    el.textContent = Math.floor(current);
  }, 16);
});
// Charts
document.addEventListener('DOMContentLoaded', function() {
  var primary = getComputedStyle(document.documentElement).getPropertyValue('--primary').trim() || '#3B82F6';
  var secondary = getComputedStyle(document.documentElement).getPropertyValue('--secondary').trim() || '#60A5FA';

  new Chart(document.getElementById('lineChart'), {
    type: 'line',
    data: {
      labels: ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'],
      datasets: [{
        label: 'Users', data: [12,19,15,25,22,30,28,35,32,40,38,45],
        borderColor: primary, backgroundColor: primary + '20',
        tension: 0.4, fill: true
      }]
    },
    options: { responsive: true, plugins: { legend: { display: false } } }
  });

  new Chart(document.getElementById('doughnutChart'), {
    type: 'doughnut',
    data: {
      labels: ['Active','Inactive'],
      datasets: [{ data: [${(stats.totalUsers)!80}, ${(stats.totalRoles)!20}], backgroundColor: [primary, secondary] }]
    },
    options: { responsive: true, plugins: { legend: { display: false } } }
  });
});
</script>
<script>$("#checkall").click(function(){ $('input:checkbox').not(this).prop('checked', this.checked); });</script>
</body>
</html>
