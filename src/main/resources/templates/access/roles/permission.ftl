<#ftl output_format="HTML">
<!DOCTYPE html>
<html lang="en">
<head>
  <#include "/layouts/head.ftl">
  <title>${setting.name!"KotlinAdmin"} - Role Permissions</title>
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
      <div class="tw-card p-0 overflow-hidden">
        <div class="px-6 py-4 border-b flex items-center justify-between">
          <div>
            <h2 class="text-lg font-semibold" style="color:var(--primary)">Permissions for Role: ${role.name!""}</h2>
            <p class="text-gray-400 text-sm mt-0.5">Assign or unassign permissions for this role</p>
          </div>
          <div class="flex gap-2">
            <a href="/admin/v1/access/role" class="btn btn-light btn-sm"><i class="fas fa-arrow-left"></i> Back</a>
          </div>
        </div>

        <#-- Bulk actions -->
        <div class="px-6 py-3 border-b bg-gray-50 flex gap-2">
          <button class="btn btn-success btn-sm" form="assign-selection"
                  formaction="/admin/v1/access/role/${role.id}/permission/assign_selected?_csrf=${_csrf}"
                  data-confirm="Assign selected permissions?">
            <i class="fas fa-plus-circle"></i> Assign Selected
          </button>
          <button class="btn btn-danger btn-sm" form="unassign-selection"
                  formaction="/admin/v1/access/role/${role.id}/permission/unassign_selected?_csrf=${_csrf}"
                  data-confirm="Unassign selected permissions?">
            <i class="fas fa-minus-circle"></i> Unassign Selected
          </button>
        </div>

        <div class="p-4" style="overflow-x:auto">
          <table class="table table-bordered table-hover align-middle">
            <thead>
              <tr>
                <th></th>
                <th>
                  <form id="searchform" method="GET" action="/admin/v1/access/role/${role.id}/permission">
                    <input type="hidden" name="roleId" value="${role.id}">
                    <select name="q_page_size" class="form-control" style="min-width:70px" onchange="this.form.submit()">
                      <option value="10" <#if (filter.q_page_size!"10") == "10">selected</#if>>10</option>
                      <option value="20" <#if (filter.q_page_size!"") == "20">selected</#if>>20</option>
                      <option value="50" <#if (filter.q_page_size!"") == "50">selected</#if>>50</option>
                    </select>
                  </form>
                </th>
                <th><input type="text" form="searchform" name="q_name" value="${(filter.q_name)!""}" placeholder="Name" class="form-control" style="min-width:120px"></th>
                <th>
                  <select form="searchform" name="q_status" class="form-control" style="min-width:100px">
                    <option value="">All</option>
                    <option value="Active" <#if (filter.q_status!"") == "Active">selected</#if>>Assigned</option>
                    <option value="Inactive" <#if (filter.q_status!"") == "Inactive">selected</#if>>Not Assigned</option>
                  </select>
                </th>
                <th>
                  <select form="searchform" name="q_guard" class="form-control" style="min-width:80px">
                    <option value="">All Guard</option>
                    <option value="web" <#if (filter.q_guard!"") == "web">selected</#if>>web</option>
                    <option value="api" <#if (filter.q_guard!"") == "api">selected</#if>>api</option>
                  </select>
                </th>
                <th></th>
                <th>
                  <div class="btn-group">
                    <button form="searchform" class="btn btn-sm btn-success"><i class="fas fa-search"></i></button>
                    <a href="/admin/v1/access/role/${role.id}/permission" class="btn btn-sm btn-danger"><i class="fas fa-times"></i></a>
                  </div>
                </th>
              </tr>
              <tr>
                <th><input type="checkbox" id="checkall"></th>
                <th>No</th>
                <th>Name</th>
                <th>Assigned</th>
                <th>Guard</th>
                <th>Method</th>
                <th>Action</th>
              </tr>
            </thead>
            <tbody>
              <form id="assign-selection" method="POST"><input type="hidden" name="_csrf" value="${_csrf}"></form>
              <form id="unassign-selection" method="POST"><input type="hidden" name="_csrf" value="${_csrf}"></form>
              <#if datas?? && datas?size gt 0>
                <#list datas as item>
                <tr>
                  <td>
                    <input type="checkbox" form="assign-selection" name="selected[]" value="${item.id}"
                           <#if item.assigned!false>form="unassign-selection"</#if>>
                  </td>
                  <td>${(paginate_data.page - 1) * paginate_data.pageSize + item?index + 1}</td>
                  <td class="text-xs font-mono">${item.name!""}</td>
                  <td>
                    <#if item.assigned!false>
                      <i class="fas fa-check-circle text-blue-500 text-xl" title="Assigned"></i>
                    <#else>
                      <i class="fas fa-times-circle text-gray-300 text-xl" title="Not assigned"></i>
                    </#if>
                  </td>
                  <td><span class="badge <#if (item.guardName!"web") == "api">text-bg-warning<#else>text-bg-info</#if>">${item.guardName!"web"}</span></td>
                  <td><span class="badge text-bg-success">${item.method!""}</span></td>
                  <td>
                    <div class="btn-group relative">
                      <button class="btn btn-sm btn-primary dropdown-toggle" data-toggle-dd>Action</button>
                      <div class="dropdown-menu dropdown-menu-end">
                        <#if !(item.assigned!false)>
                          <a class="dropdown-item text-green-700"
                             href="/admin/v1/access/role/${role.id}/permission/${item.id}/assign">
                            <i class="fas fa-plus-circle"></i> Assign
                          </a>
                        <#else>
                          <a class="dropdown-item text-red-600"
                             href="/admin/v1/access/role/${role.id}/permission/${item.id}/unassign">
                            <i class="fas fa-minus-circle"></i> Unassign
                          </a>
                        </#if>
                      </div>
                    </div>
                  </td>
                </tr>
                </#list>
              <#else>
                <tr><td colspan="7" class="text-center text-gray-400 py-8">No permissions found</td></tr>
              </#if>
            </tbody>
          </table>
          <#if paginate_data??>
          <nav class="mt-4">
            <ul class="pagination">
              <li class="page-item <#if !paginate_data.hasPrev>disabled</#if>">
                <a class="page-link" href="?q_page=${paginate_data.page - 1}&q_page_size=${(filter.q_page_size)!"10"}">Previous</a>
              </li>
              <#list 1..paginate_data.totalPages as p>
                <#if p == 1 || p == paginate_data.totalPages || (p >= paginate_data.page - 2 && p <= paginate_data.page + 2)>
                  <li class="page-item <#if p == paginate_data.page>active</#if>">
                    <a class="page-link" href="?q_page=${p}&q_page_size=${(filter.q_page_size)!"10"}">${p}</a>
                  </li>
                <#elseif p == 2 || p == paginate_data.totalPages - 1>
                  <li class="page-item disabled"><a class="page-link" href="#">…</a></li>
                </#if>
              </#list>
              <li class="page-item <#if !paginate_data.hasNext>disabled</#if>">
                <a class="page-link" href="?q_page=${paginate_data.page + 1}&q_page_size=${(filter.q_page_size)!"10"}">Next</a>
              </li>
            </ul>
          </nav>
          </#if>
        </div>
      </div>
    </main>
  </div>
</div>
<#include "/layouts/foot.ftl">
<script>$("#checkall").click(function(){
  $('input:checkbox').not(this).prop('checked', this.checked);
});</script>
</body>
</html>
