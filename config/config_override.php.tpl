<?php
  if (null !== $$installer_defaults) {
      $$installer_defaults['setup_db_host_name']            = "{{ DB_HOST_NAME | default('yetiforce:3306') }}";
      $$installer_defaults['setup_db_database_name']        = "{{ DB_DATABASE_NAME | default('yetiforce') }}";
      $$installer_defaults['setup_db_admin_user_name']      = "{{ DB_ADMIN_USER_NAME | default('yetiforce') }}";
      $$installer_defaults['setup_db_admin_password']       = "{{ DB_ADMIN_PASSWORD | default('yetiforce') }}";
      $$installer_defaults['db_type']                       = "{{ DB_TYPE | default('mysql') }}";
  }

  if (null !== $$sugar_config) {
      $$sugar_config['dbconfig']['db_port'] = "{{ DB_TCP_PORT | default('3306') }}";
      $$sugar_config['dbconfig']['db_manager'] = "{{ DB_MANAGER | default('yetiforce') }}";
      $$sugar_config['dbconfig']['db_host_name'] = "{{ DB_HOST_NAME | default('yetiforce') }}";
      $$sugar_config['dbconfig']['db_user_name'] = "{{ DB_USER_NAME | default('yetiforce') }}";
      $$sugar_config['dbconfig']['db_password'] = "{{ DB_PASSWORD | default('yetiforce') }}";
  }
?>
