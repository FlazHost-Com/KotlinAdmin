<#ftl output_format="HTML">
<!DOCTYPE html>
<html lang="en">
<head>
  <#include "/layouts/head.ftl">
  <title>${setting.name!"KotlinAdmin"} - UI Components</title>
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
    <main class="flex-1 p-6 space-y-8">

      <h1 class="text-2xl font-bold" style="color:var(--primary)">UI Components Showcase</h1>

      <!-- Buttons -->
      <div class="tw-card p-6" id="buttons">
        <h2 class="font-semibold text-lg mb-4 border-b pb-2">Buttons</h2>
        <div class="flex flex-wrap gap-2 mb-4">
          <button class="btn btn-primary">Primary</button>
          <button class="btn btn-success">Success</button>
          <button class="btn btn-danger">Danger</button>
          <button class="btn btn-warning">Warning</button>
          <button class="btn btn-info">Info</button>
          <button class="btn btn-light">Light</button>
        </div>
        <div class="flex flex-wrap gap-2 mb-4">
          <button class="btn btn-primary btn-sm">Small Primary</button>
          <button class="btn btn-success btn-sm">Small Success</button>
          <button class="btn btn-danger btn-sm">Small Danger</button>
        </div>
        <div class="flex flex-wrap gap-2">
          <button class="btn btn-primary" disabled>Disabled</button>
          <a href="#" class="btn btn-info"><i class="fas fa-eye mr-1"></i> With Icon</a>
          <button class="btn btn-warning" data-confirm="Are you sure?">With Confirm</button>
        </div>
      </div>

      <!-- Badges -->
      <div class="tw-card p-6" id="badges">
        <h2 class="font-semibold text-lg mb-4 border-b pb-2">Badges</h2>
        <div class="flex flex-wrap gap-2">
          <span class="badge text-bg-primary">Primary</span>
          <span class="badge text-bg-success">Success</span>
          <span class="badge text-bg-danger">Danger</span>
          <span class="badge text-bg-warning">Warning</span>
          <span class="badge text-bg-info">Info</span>
          <span class="badge text-bg-secondary">Secondary</span>
          <span class="badge rounded-pill text-bg-primary">Pill</span>
        </div>
      </div>

      <!-- Alerts / Flash -->
      <div class="tw-card p-6" id="alerts">
        <h2 class="font-semibold text-lg mb-4 border-b pb-2">Alerts</h2>
        <div class="p-4 rounded-lg bg-green-100 border border-green-300 text-green-800 mb-3 flex items-start gap-2">
          <i class="fas fa-check-circle mt-0.5"></i>
          <span><strong>Success!</strong> Operation completed successfully.</span>
        </div>
        <div class="p-4 rounded-lg bg-red-100 border border-red-300 text-red-800 mb-3 flex items-start gap-2">
          <i class="fas fa-times-circle mt-0.5"></i>
          <span><strong>Error!</strong> Something went wrong.</span>
        </div>
        <div class="p-4 rounded-lg bg-yellow-100 border border-yellow-300 text-yellow-800 mb-3 flex items-start gap-2">
          <i class="fas fa-exclamation-triangle mt-0.5"></i>
          <span><strong>Warning!</strong> Please review before continuing.</span>
        </div>
        <div class="p-4 rounded-lg bg-blue-100 border border-blue-300 text-blue-800 flex items-start gap-2">
          <i class="fas fa-info-circle mt-0.5"></i>
          <span><strong>Info:</strong> This is an informational message.</span>
        </div>
        <div class="mt-4">
          <button class="btn btn-success btn-sm" onclick="showToast('success', 'This is a success toast!')">Show Toast (Success)</button>
          <button class="btn btn-danger btn-sm ml-2" onclick="showToast('danger', 'This is an error toast!')">Show Toast (Error)</button>
        </div>
      </div>

      <!-- Form Controls -->
      <div class="tw-card p-6" id="forms">
        <h2 class="font-semibold text-lg mb-4 border-b pb-2">Form Controls</h2>
        <div class="grid grid-cols-1 md:grid-cols-2 gap-4 max-w-2xl">
          <div>
            <label class="form-label">Text Input</label>
            <input type="text" class="form-control" placeholder="Type here...">
          </div>
          <div>
            <label class="form-label">Email Input</label>
            <input type="email" class="form-control" placeholder="email@example.com">
          </div>
          <div>
            <label class="form-label">Invalid Input</label>
            <input type="text" class="form-control is-invalid" value="Bad value">
            <div class="invalid-feedback">This field has an error.</div>
          </div>
          <div>
            <label class="form-label">Select</label>
            <select class="form-control">
              <option>Option 1</option>
              <option>Option 2</option>
              <option>Option 3</option>
            </select>
          </div>
          <div>
            <label class="form-label">Select2 (searchable)</label>
            <select class="form-control select2">
              <option value="">-- Choose --</option>
              <option>JavaScript</option>
              <option>Kotlin</option>
              <option>Rust</option>
              <option>Go</option>
            </select>
          </div>
          <div>
            <label class="form-label">Textarea</label>
            <textarea rows="3" class="form-control" placeholder="Write something..."></textarea>
          </div>
          <div>
            <label class="form-label">File Input</label>
            <input type="file" class="form-control">
          </div>
          <div>
            <label class="form-label">Checkbox & Radio</label>
            <div class="flex gap-4 mt-1">
              <label class="flex items-center gap-2"><input type="checkbox" checked> Option A</label>
              <label class="flex items-center gap-2"><input type="checkbox"> Option B</label>
            </div>
          </div>
        </div>
      </div>

      <!-- WYSIWYG -->
      <div class="tw-card p-6" id="wysiwyg">
        <h2 class="font-semibold text-lg mb-4 border-b pb-2">WYSIWYG Editor (Trumbowyg)</h2>
        <textarea class="form-control trumbowyg" rows="5" placeholder="Rich text here..."></textarea>
      </div>

      <!-- Table -->
      <div class="tw-card p-0 overflow-hidden" id="tables">
        <div class="px-6 py-4 border-b">
          <h2 class="font-semibold text-lg">Data Table</h2>
        </div>
        <div class="p-4 overflow-x-auto">
          <table class="table table-bordered table-hover align-middle">
            <thead>
              <tr>
                <th><input type="checkbox"></th>
                <th>No</th>
                <th>Name</th>
                <th>Status</th>
                <th>Role</th>
                <th>Action</th>
              </tr>
            </thead>
            <tbody>
              <#assign rows = [
                {"name": "Alice Johnson", "status": "Active", "role": "Admin"},
                {"name": "Bob Smith", "status": "Inactive", "role": "Editor"},
                {"name": "Carol White", "status": "Active", "role": "Viewer"}
              ]>
              <#list rows as row>
              <tr>
                <td><input type="checkbox"></td>
                <td>${row?index + 1}</td>
                <td>${row.name}</td>
                <td>
                  <#if row.status == "Active">
                    <i class="fas fa-check-circle text-green-500 text-xl"></i>
                  <#else>
                    <i class="fas fa-times-circle text-red-500 text-xl"></i>
                  </#if>
                </td>
                <td><span class="badge text-bg-info">${row.role}</span></td>
                <td>
                  <div class="btn-group relative">
                    <button class="btn btn-sm btn-primary dropdown-toggle" data-toggle-dd>Action</button>
                    <div class="dropdown-menu dropdown-menu-end">
                      <a href="#" class="dropdown-item"><i class="fas fa-edit"></i> Edit</a>
                      <div class="dropdown-divider"></div>
                      <a href="#" class="dropdown-item text-danger"><i class="fas fa-trash"></i> Delete</a>
                    </div>
                  </div>
                </td>
              </tr>
              </#list>
            </tbody>
          </table>
        </div>
      </div>

      <!-- Charts -->
      <div class="tw-card p-6" id="charts">
        <h2 class="font-semibold text-lg mb-4 border-b pb-2">Charts (Chart.js)</h2>
        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
          <div>
            <h3 class="text-sm font-medium text-gray-500 mb-2">Line Chart</h3>
            <canvas id="comp-line-chart" height="200"></canvas>
          </div>
          <div>
            <h3 class="text-sm font-medium text-gray-500 mb-2">Doughnut Chart</h3>
            <canvas id="comp-donut-chart" height="200"></canvas>
          </div>
        </div>
      </div>

      <!-- Image with fallback -->
      <div class="tw-card p-6" id="images">
        <h2 class="font-semibold text-lg mb-4 border-b pb-2">Images with Auto-Fallback</h2>
        <div class="flex gap-4 flex-wrap items-end">
          <div class="text-center">
            <img src="/uploads/nonexistent-avatar.jpg" alt="avatar" width="80" height="80"
                 class="rounded-full object-cover border-2 border-gray-200 mb-1">
            <p class="text-xs text-gray-400">Avatar (broken)</p>
          </div>
          <div class="text-center">
            <img src="/uploads/nonexistent-image.jpg" alt="image" width="120" height="80"
                 class="rounded object-cover border border-gray-200 mb-1">
            <p class="text-xs text-gray-400">Image (broken)</p>
          </div>
        </div>
        <p class="text-xs text-gray-400 mt-2">Broken images automatically show a placeholder icon via foot.ftl JS.</p>
      </div>

      <!-- Pagination -->
      <div class="tw-card p-6" id="pagination">
        <h2 class="font-semibold text-lg mb-4 border-b pb-2">Pagination</h2>
        <nav>
          <ul class="pagination">
            <li class="page-item disabled"><a class="page-link" href="#">Previous</a></li>
            <li class="page-item active"><a class="page-link" href="#">1</a></li>
            <li class="page-item"><a class="page-link" href="#">2</a></li>
            <li class="page-item"><a class="page-link" href="#">3</a></li>
            <li class="page-item disabled"><a class="page-link" href="#">…</a></li>
            <li class="page-item"><a class="page-link" href="#">10</a></li>
            <li class="page-item"><a class="page-link" href="#">Next</a></li>
          </ul>
        </nav>
      </div>

    </main>
  </div>
</div>
<#include "/layouts/foot.ftl">
<script>
const compPrimary = getComputedStyle(document.documentElement).getPropertyValue('--primary').trim() || '#3B82F6';
new Chart(document.getElementById('comp-line-chart'), {
  type: 'line',
  data: {
    labels: ['Jan','Feb','Mar','Apr','May','Jun'],
    datasets: [{ label: 'Data', data: [30,50,40,80,60,90],
      borderColor: compPrimary, backgroundColor: compPrimary + '22', fill: true, tension: 0.4 }]
  },
  options: { responsive: true, plugins: { legend: { display: false } } }
});
new Chart(document.getElementById('comp-donut-chart'), {
  type: 'doughnut',
  data: {
    labels: ['A', 'B', 'C'],
    datasets: [{ data: [40, 35, 25], backgroundColor: [compPrimary, '#34D399', '#F87171'] }]
  },
  options: { responsive: true }
});
function showToast(type, msg) {
  const tc = document.getElementById('toast-container');
  if (!tc) return;
  const t = document.createElement('div');
  t.className = `flex items-center gap-2 px-4 py-3 rounded-lg shadow-lg text-white text-sm mb-2 ${type === 'success' ? 'bg-green-600' : 'bg-red-600'}`;
  t.innerHTML = `<i class="fas ${type === 'success' ? 'fa-check-circle' : 'fa-times-circle'}"></i><span>${msg}</span>`;
  tc.appendChild(t);
  setTimeout(() => t.remove(), 4000);
}
</script>
</body>
</html>
