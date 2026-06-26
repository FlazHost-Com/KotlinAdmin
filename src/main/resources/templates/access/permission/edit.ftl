<#ftl output_format="HTML">
<!DOCTYPE html>
<html lang="en">
<head>
  <#include "/layouts/head.ftl">
  <title>${setting.name!"KotlinAdmin"} - Edit Permission</title>
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
      <div class="tw-card p-6 max-w-2xl mx-auto">
        <div class="flex items-center justify-between mb-6">
          <h2 class="text-lg font-semibold" style="color:var(--primary)">Edit Permission</h2>
          <a href="/admin/v1/access/permission" class="btn btn-light btn-sm">
            <i class="fas fa-arrow-left"></i> Back
          </a>
        </div>
        <form method="POST" action="/admin/v1/access/permission/${data.id}/update?_method=PUT&_csrf=${_csrf}">
          <div class="mb-4">
            <label class="form-label">[name] Name</label>
            <input type="text" name="name" value="${(old.name)!(data.name)!""}"
                   class="form-control <#if (errors.name)??>is-invalid</#if>"
                   placeholder="admin.v1.access.permission.index" required>
            <div class="form-text text-gray-400">Dot-notation: <code>{guard}.{module}.{resource}.{action}</code></div>
            <#if (errors.name)??><div class="invalid-feedback">${errors.name}</div></#if>
          </div>
          <div class="mb-4">
            <label class="form-label">[method] HTTP Method</label>
            <select name="method" class="form-control <#if (errors.method)??>is-invalid</#if>">
              <option value="GET" <#if ((old.method)!(data.method)!"GET") == "GET">selected</#if>>GET</option>
              <option value="POST" <#if ((old.method)!(data.method)!"") == "POST">selected</#if>>POST</option>
              <option value="PUT" <#if ((old.method)!(data.method)!"") == "PUT">selected</#if>>PUT</option>
              <option value="DELETE" <#if ((old.method)!(data.method)!"") == "DELETE">selected</#if>>DELETE</option>
            </select>
            <#if (errors.method)??><div class="invalid-feedback">${errors.method}</div></#if>
          </div>
          <div class="mb-4">
            <label class="form-label">[guard_name] Guard</label>
            <select name="guardName" class="form-control">
              <option value="web" <#if ((old.guardName)!(data.guardName)!"web") == "web">selected</#if>>web</option>
              <option value="api" <#if ((old.guardName)!(data.guardName)!"") == "api">selected</#if>>api</option>
            </select>
          </div>
          <div class="mb-6">
            <label class="form-label">[path] Route Path</label>
            <input type="text" name="path" value="${(old.path)!(data.path)!""}"
                   class="form-control <#if (errors.path)??>is-invalid</#if>"
                   placeholder="/admin/v1/access/permission">
            <#if (errors.path)??><div class="invalid-feedback">${errors.path}</div></#if>
          </div>
          <div class="flex gap-2">
            <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> Update Permission</button>
            <a href="/admin/v1/access/permission" class="btn btn-light">Cancel</a>
          </div>
        </form>
      </div>
    </main>
  </div>
</div>
<#include "/layouts/foot.ftl">
</body>
</html>
