<#ftl output_format="HTML">
<!DOCTYPE html>
<html lang="en">
<head>
  <#include "/layouts/head.ftl">
  <title>${setting.name!"KotlinAdmin"} - Settings</title>
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
      <form method="POST" action="/admin/v1/setting/update?_method=PUT&_csrf=${_csrf}" enctype="multipart/form-data">

        <!-- General -->
        <div class="tw-card p-6 mb-6">
          <h2 class="text-lg font-semibold mb-4" style="color:var(--primary)">General Settings</h2>
          <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div>
              <label class="form-label">[name] App Name</label>
              <input type="text" name="name" value="${setting.name!""}" class="form-control" required>
            </div>
            <div>
              <label class="form-label">[tagline] Tagline</label>
              <input type="text" name="tagline" value="${setting.tagline!""}" class="form-control">
            </div>
            <div>
              <label class="form-label">[description] Description</label>
              <textarea name="description" rows="3" class="form-control">${setting.description!""}</textarea>
            </div>
            <div>
              <label class="form-label">[keywords] Keywords</label>
              <input type="text" name="keywords" value="${setting.keywords!""}" class="form-control">
            </div>
            <div>
              <label class="form-label">[email] Contact Email</label>
              <input type="email" name="email" value="${setting.email!""}" class="form-control">
            </div>
            <div>
              <label class="form-label">[phone] Phone</label>
              <input type="text" name="phone" value="${setting.phone!""}" class="form-control">
            </div>
            <div>
              <label class="form-label">[address] Address</label>
              <textarea name="address" rows="2" class="form-control">${setting.address!""}</textarea>
            </div>
            <div>
              <label class="form-label">[timezone] Default Timezone</label>
              <select name="timezone" class="form-control select2">
                <#assign tzList = ["UTC","Asia/Jakarta","Asia/Makassar","Asia/Jayapura","Asia/Singapore","America/New_York","America/Los_Angeles","Europe/London","Europe/Paris"]>
                <#list tzList as tz>
                  <option value="${tz}" <#if (setting.timezone!"UTC") == tz>selected</#if>>${tz}</option>
                </#list>
              </select>
            </div>
          </div>
        </div>

        <!-- Theme -->
        <div class="tw-card p-6 mb-6">
          <h2 class="text-lg font-semibold mb-4" style="color:var(--primary)">Theme</h2>
          <div class="mb-4">
            <label class="form-label">[theme] Active Theme</label>
            <div class="d-flex gap-2 flex-wrap">
              <#list themes as t>
              <label class="cursor-pointer">
                <input type="radio" name="theme" value="${t.name}" class="sr-only"
                       <#if (setting.theme!"Blue") == t.name>checked</#if>
                       onchange="applyThemePreview(this)">
                <div class="tw-card p-2 theme-swatch-card"
                     style="width:80px;cursor:pointer;border:2px solid <#if (setting.theme!"Blue") == t.name>var(--primary)<#else>transparent</#if>">
                  <div class="rounded mb-1" style="height:20px;background:${t.primary}"></div>
                  <div class="rounded" style="height:8px;background:${t.secondary}"></div>
                  <p class="text-xs mt-1 text-center">${t.name}</p>
                </div>
              </label>
              </#list>
            </div>
          </div>
          <div class="flex gap-2">
            <button type="button" class="btn btn-light btn-sm"
                    onclick="document.getElementById('fe-catalog-modal').style.display='flex'">
              <i class="fas fa-th-large"></i> FE Templates
            </button>
          </div>
        </div>

        <!-- Logo / Images -->
        <div class="tw-card p-6 mb-6">
          <h2 class="text-lg font-semibold mb-4" style="color:var(--primary)">Branding</h2>
          <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
            <div>
              <label class="form-label">[logo] Logo</label>
              <img id="logo-preview" src="${setting.logo!""}" alt="logo" width="80" height="80"
                   class="rounded mb-2 object-contain border border-gray-200 bg-white" style="display:block">
              <input type="file" name="logo" accept="image/*" class="form-control"
                     onchange="previewImage(this, 'logo-preview')">
            </div>
            <div>
              <label class="form-label">[icon] App Icon</label>
              <img id="icon-preview" src="${setting.icon!""}" alt="icon" width="40" height="40"
                   class="rounded mb-2 object-contain border border-gray-200 bg-white" style="display:block">
              <input type="file" name="icon" accept="image/*" class="form-control"
                     onchange="previewImage(this, 'icon-preview')">
            </div>
            <div>
              <label class="form-label">[favicon] Favicon</label>
              <#if setting.favicon?has_content>
              <img id="favicon-preview" src="${setting.favicon}" alt="favicon" width="32" height="32"
                   class="rounded mb-2 object-contain border border-gray-200 bg-white" style="display:block">
              <#else>
              <img id="favicon-preview" src="" alt="favicon" width="32" height="32"
                   class="rounded mb-2 object-contain border border-gray-200 bg-white" style="display:none">
              </#if>
              <input type="file" name="favicon" accept="image/*" class="form-control"
                     onchange="previewImage(this, 'favicon-preview')">
            </div>
            <div>
              <label class="form-label">[login_image] Login Image</label>
              <img id="login-img-preview" src="${setting.loginImage!""}" alt="login image" width="120" height="80"
                   class="rounded mb-2 object-cover border border-gray-200" style="display:block">
              <input type="file" name="loginImage" accept="image/*" class="form-control"
                     onchange="previewImage(this, 'login-img-preview')">
            </div>
          </div>
        </div>

        <!-- Auth -->
        <div class="tw-card p-6 mb-6">
          <h2 class="text-lg font-semibold mb-4" style="color:var(--primary)">Auth & Features</h2>
          <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div>
              <label class="form-label">[allow_register] Allow Registration</label>
              <select name="allowRegister" class="form-control">
                <option value="1" <#if (setting.allowRegister!"1") == "1">selected</#if>>Yes</option>
                <option value="0" <#if (setting.allowRegister!"") == "0">selected</#if>>No</option>
              </select>
            </div>
            <div>
              <label class="form-label">[allow_reset_password] Allow Password Reset</label>
              <select name="allowResetPassword" class="form-control">
                <option value="1" <#if (setting.allowResetPassword!"1") == "1">selected</#if>>Yes</option>
                <option value="0" <#if (setting.allowResetPassword!"") == "0">selected</#if>>No</option>
              </select>
            </div>
            <div>
              <label class="form-label">[maintenance_mode] Maintenance Mode</label>
              <select name="maintenanceMode" class="form-control">
                <option value="0" <#if (setting.maintenanceMode!"0") == "0">selected</#if>>Off</option>
                <option value="1" <#if (setting.maintenanceMode!"") == "1">selected</#if>>On</option>
              </select>
            </div>
            <div>
              <label class="form-label">[maintenance_message] Maintenance Message</label>
              <input type="text" name="maintenanceMessage" value="${setting.maintenanceMessage!""}" class="form-control">
            </div>
          </div>
        </div>

        <div class="flex gap-2 pb-4">
          <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> Save Settings</button>
        </div>
      </form>
    </main>
  </div>
</div>
<#-- FE Template Catalog Modal -->
<div id="fe-catalog-modal" style="display:none;position:fixed;inset:0;z-index:9999;background:rgba(0,0,0,.5);align-items:center;justify-content:center;">
  <div class="tw-card" style="width:600px;max-width:95vw;max-height:80vh;display:flex;flex-direction:column;">
    <div class="modal-header">
      <span class="modal-title">FE Template Catalog</span>
      <button class="modal-close" onclick="document.getElementById('fe-catalog-modal').style.display='none'">&times;</button>
    </div>
    <div class="modal-body" style="overflow-y:auto;flex:1;">
      <p class="text-gray-500 text-sm mb-4">Select a front-end template for your site.</p>
      <div class="grid grid-cols-2 gap-3" id="fe-catalog-grid">
        <#assign feOptions = ["agency-consulting-002-creative-agency","portfolio-001-minimal","corporate-003-professional","landing-004-startup"]>
        <#list feOptions as fe>
        <div class="tw-card p-3 cursor-pointer hover:border-primary-tw"
             style="border:2px solid <#if (setting.fe_template!"") == fe>var(--primary)<#else>#e5e7eb</#if>"
             onclick="selectFeTemplate('${fe}')">
          <p class="text-xs font-mono text-gray-600 break-all">${fe}</p>
          <#if (setting.fe_template!"") == fe>
          <span class="badge text-bg-primary mt-1">Active</span>
          </#if>
        </div>
        </#list>
      </div>
    </div>
    <div class="modal-footer">
      <button class="btn btn-light btn-sm" onclick="document.getElementById('fe-catalog-modal').style.display='none'">Close</button>
    </div>
  </div>
</div>

<#include "/layouts/foot.ftl">
<script>
// Theme live preview
var THEME_MAP = {};
<#list themes as t>
THEME_MAP['${t.name}'] = { primary: '${t.primary}', secondary: '${t.secondary}', light: '${t.light}', dark: '${t.dark}' };
</#list>

function applyThemePreview(radio) {
  var t = THEME_MAP[radio.value];
  if (!t) return;
  document.documentElement.style.setProperty('--primary', t.primary);
  document.documentElement.style.setProperty('--secondary', t.secondary);
  document.documentElement.style.setProperty('--theme-light', t.light);
  document.documentElement.style.setProperty('--theme-dark', t.dark);
  // Update swatch borders
  document.querySelectorAll('input[name="theme"]').forEach(function(r) {
    var card = r.nextElementSibling;
    if (card) card.style.borderColor = r.checked ? 'var(--primary)' : 'transparent';
  });
}

// FE template picker
function selectFeTemplate(slug) {
  var hidden = document.querySelector('input[name="fe_template"]');
  if (!hidden) {
    hidden = document.createElement('input');
    hidden.type = 'hidden';
    hidden.name = 'fe_template';
    document.querySelector('form').appendChild(hidden);
  }
  hidden.value = slug;
  document.getElementById('fe-catalog-modal').style.display = 'none';
  window.Toast && window.Toast('Template selected: ' + slug, 'success');
}
</script>
</body>
</html>
