<#ftl output_format="HTML">
<!DOCTYPE html>
<html lang="en">
<head>
  <#include "/layouts/head.ftl">
  <title>${setting.name!"KotlinAdmin"} - Create Role</title>
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
          <h2 class="text-lg font-semibold" style="color:var(--primary)">Create Role</h2>
          <a href="/admin/v1/access/role" class="btn btn-light btn-sm">
            <i class="fas fa-arrow-left"></i> Back
          </a>
        </div>
        <form method="POST" action="/admin/v1/access/role/store?_csrf=${_csrf}">
          <div class="mb-4">
            <label class="form-label">[name] Name</label>
            <input type="text" name="name" value="${(old.name)!""}"
                   class="form-control <#if (errors.name)??>is-invalid</#if>"
                   placeholder="Role name" required>
            <#if (errors.name)??><div class="invalid-feedback">${errors.name}</div></#if>
          </div>
          <div class="mb-4">
            <label class="form-label">[desc] Description</label>
            <textarea name="description" rows="3"
                      class="form-control <#if (errors.description)??>is-invalid</#if>"
                      placeholder="Role description...">${(old.description)!""}</textarea>
            <#if (errors.description)??><div class="invalid-feedback">${errors.description}</div></#if>
          </div>
          <div class="mb-6">
            <label class="form-label">[status] Status</label>
            <select name="status" class="form-control">
              <option value="Active" <#if (old.status!"Active") == "Active">selected</#if>>Active</option>
              <option value="Inactive" <#if (old.status!"") == "Inactive">selected</#if>>Inactive</option>
            </select>
          </div>
          <div class="flex gap-2">
            <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> Save Role</button>
            <a href="/admin/v1/access/role" class="btn btn-light">Cancel</a>
          </div>
        </form>
      </div>
    </main>
  </div>
</div>
<#include "/layouts/foot.ftl">
</body>
</html>
