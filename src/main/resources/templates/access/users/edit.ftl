<#ftl output_format="HTML">
<!DOCTYPE html>
<html lang="en">
<head>
  <#include "/layouts/head.ftl">
  <title>${setting.name!"KotlinAdmin"} - Edit User</title>
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
      <div class="tw-card p-6 max-w-3xl mx-auto">
        <div class="flex items-center justify-between mb-6">
          <h2 class="text-lg font-semibold" style="color:var(--primary)">Edit User</h2>
          <a href="/admin/v1/access/user" class="btn btn-light btn-sm">
            <i class="fas fa-arrow-left"></i> Back
          </a>
        </div>

        <form method="POST" action="/admin/v1/access/user/${data.id}/update?_method=PUT&_csrf=${_csrf}" enctype="multipart/form-data">
          <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div>
              <label class="form-label">[code] Code</label>
              <input type="text" name="code" value="${(old.code)!(data.code)!""}"
                     class="form-control <#if (errors.code)??>is-invalid</#if>"
                     placeholder="USR-001" required>
              <#if (errors.code)??><div class="invalid-feedback">${errors.code}</div></#if>
            </div>
            <div>
              <label class="form-label">[name] Name</label>
              <input type="text" name="name" value="${(old.name)!(data.name)!""}"
                     class="form-control <#if (errors.name)??>is-invalid</#if>"
                     placeholder="Full Name" required>
              <#if (errors.name)??><div class="invalid-feedback">${errors.name}</div></#if>
            </div>
            <div>
              <label class="form-label">[phone] Phone</label>
              <input type="text" name="phone" value="${(old.phone)!(data.phone)!""}"
                     class="form-control <#if (errors.phone)??>is-invalid</#if>">
              <#if (errors.phone)??><div class="invalid-feedback">${errors.phone}</div></#if>
            </div>
            <div>
              <label class="form-label">[email] Email</label>
              <input type="email" name="email" value="${(old.email)!(data.email)!""}"
                     class="form-control <#if (errors.email)??>is-invalid</#if>" required>
              <#if (errors.email)??><div class="invalid-feedback">${errors.email}</div></#if>
            </div>
            <div>
              <label class="form-label">[password] New Password <span class="text-gray-400 font-normal">(leave blank to keep)</span></label>
              <input type="password" name="password"
                     class="form-control <#if (errors.password)??>is-invalid</#if>"
                     placeholder="Leave blank to keep current">
              <#if (errors.password)??><div class="invalid-feedback">${errors.password}</div></#if>
            </div>
            <div>
              <label class="form-label">[password_confirm] Confirm Password</label>
              <input type="password" name="passwordConfirm"
                     class="form-control <#if (errors.passwordConfirm)??>is-invalid</#if>">
              <#if (errors.passwordConfirm)??><div class="invalid-feedback">${errors.passwordConfirm}</div></#if>
            </div>
            <div>
              <label class="form-label">[status] Status</label>
              <select name="status" class="form-control">
                <option value="Active" <#if ((old.status)!(data.status)!"Active") == "Active">selected</#if>>Active</option>
                <option value="Inactive" <#if ((old.status)!(data.status)!"") == "Inactive">selected</#if>>Inactive</option>
              </select>
            </div>
            <div>
              <label class="form-label">[timezone] Timezone</label>
              <select name="timezone" class="form-control select2">
                <#assign timezones = ["UTC","Asia/Jakarta","Asia/Makassar","Asia/Jayapura","Asia/Singapore","America/New_York","America/Los_Angeles","Europe/London","Europe/Paris"]>
                <#list timezones as tz>
                  <option value="${tz}" <#if ((old.timezone)!(data.timezone)!"UTC") == tz>selected</#if>>${tz}</option>
                </#list>
              </select>
            </div>
            <div class="md:col-span-2">
              <label class="form-label">[roles] Roles</label>
              <select name="roleIds[]" multiple class="form-control select2">
                <#if allRoles??>
                  <#list allRoles as role>
                    <#assign isSelected = false>
                    <#if data.roles??>
                      <#list data.roles as ur>
                        <#if ur.id == role.id><#assign isSelected = true></#if>
                      </#list>
                    </#if>
                    <option value="${role.id}" <#if isSelected>selected</#if>>${role.name}</option>
                  </#list>
                </#if>
              </select>
            </div>
            <div class="md:col-span-2">
              <label class="form-label">[picture] Picture</label>
              <img id="picture-preview" src="${(data.picture)!""}" alt="picture preview" width="80" height="80"
                   class="rounded mb-2 object-cover border border-gray-200" style="display:block">
              <input type="file" name="picture" accept="image/*" class="form-control"
                     onchange="previewImage(this, 'picture-preview')">
            </div>
          </div>
          <div class="mt-6 flex gap-2">
            <button type="submit" class="btn btn-primary">
              <i class="fas fa-save"></i> Update User
            </button>
            <a href="/admin/v1/access/user" class="btn btn-light">Cancel</a>
          </div>
        </form>
      </div>
    </main>
  </div>
</div>
<#include "/layouts/foot.ftl">
</body>
</html>
