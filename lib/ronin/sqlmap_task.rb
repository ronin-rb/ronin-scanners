require 'rprogram/task'

module Ronin
  #
  # ## SQLMap Options:
  #
  # * `--version` - `sqlmap.version`
  # * `--help` - `sqlmap.help`
  # * `-v` - `sqlmap.verbose`
  #
  # ### Target:
  #
  # * `-d` - `sqlmap.direct`
  # * `-u` - `sqlmap.url`
  # * `-l` - `sqlmap.list`
  # * `-r` - `sqlmap.request_file`
  # * `-g` - `sqlmap.google_dork`
  # * `-c` - `sqlmap.config_file`
  #
  # ### Request:
  #
  # * `--method` - `sqlmap.request_method`
  # * `--data` - `sqlmap.post_data`
  # * `--cookie` - `sqlmap.cookie`
  # * `--cookie-urlencode` - `sqlmap.cookie_url_encode`
  # * `--drop-set-cookie` - `sqlmap.drop_set_cookie`
  # * `--user-agent` - `sqlmap.user_agent`
  # * `-a` - `sqlmap.user_agent_file`
  # * `--referer` - `sqlmap.referer`
  # * `--headers` - `sqlmap.headers`
  # * `--auth-type` - `sqlmap.auth_type`
  # * `--auth-cred` - `sqlmap.auth_credentials`
  # * `--auth-cert` - `sqlmap.auth_cert`
  # * `--proxy` - `sqlmap.proxy`
  # * `--ignore-proxy` - `sqlmap.ignore_proxy`
  # * `--threads` - `sqlmap.threads`
  # * `--delay` - `sqlmap.delay`
  # * `--timeout` - `sqlmap.timeout`
  # * `--retries` - `sqlmap.retries`
  # * `--scope` - `sqlmap.scope`
  # * `--safe-url` - `sqlmap.safe_url`
  # * `--safe-freq` - `sqlmap.safe_frequency`
  #
  # ### Injection:
  #
  # * `-p` - `sqlmap.params`
  # * `--dbms` - `sqlmap.dbms`
  # * `--os` - `sqlmap.os`
  # * `--prefix` - `sqlmap.prefix`
  # * `--postfix` - `sqlmap.postfix`
  # * `--string` - `sqlmap.string`
  # * `--regexp` - `sqlmap.regexp`
  # * `--excl-str` - `sqlmap.exclude_string`
  # * `--excl-reg` - `sqlmap.exclude_regexp`
  # * `--use-between` - `sqlmap.use_between`
  #
  # ### Techniques:
  #
  # * `--stacked-test` - `sqlmap.stacked_test`
  # * `--time-test` - `sqlmap.time_test`
  # * `--time-sec` - `sqlmap.time_sec`
  # * `--union-test` - `sqlmap.union_test`
  # * `--union-tech` - `sqlmap.union_style`
  # * `--union-use` - `sqlmap.union_use`
  #
  # ### Fingerprint:
  #
  # * `--fingerprint` - `sqlmap.fingerprint`
  #
  # ### Enumeration:
  #
  # * `--banner` - `sqlmap.banner`
  # * `--current-user` - `sqlmap.current_user`
  # * `--current-db` - `sqlmap.current_database`
  # * `--is-dba` - `sqlmap.is_dba`
  # * `--users` - `sqlmap.users`
  # * `--passwords` - `sqlmap.passwords`
  # * `--privileges` - `sqlmap.privileges`
  # * `--roles` - `sqlmap.roles`
  # * `--dbs` - `sqlmap.databases`
  # * `--tables` - `sqlmap.tables`
  # * `--colums` - `sqlmap.colums`
  # * `--dump` - `sqlmap.dump`
  # * `--search` - `sqlmap.search`
  # * `-D` - `sqlmap.enumerate_database`
  # * `-T` - `sqlmap.enumerate_table`
  # * `-C` - `sqlmap.enumerate_column`
  # * `-U` - `sqlmap.enumerate_user`
  # * `--exclude-sysdbs` - `sqlmap.exclude_system_database`
  # * `--start` - `sqlmap.start`
  # * `--stop` - `sqlmap.stop`
  # * `--first` - `sqlmap.first`
  # * `--last` - `sqlmap.last`
  # * `--sql-query` - `sqlmap.sql_query`
  # * `--sql-shell` - `sqlmap.sql_shell`
  #
  # ### User-defined function injection:
  #
  # * `--udf-inject` - `sqlmap.udf_inject`
  # * `--shared-lib` - `sqlmap.shared_lib`
  #
  # ### File system access:
  #
  # * `--read-file` - `sqlmap.read_file`
  # * `--write-file` - `sqlmap.write_file`
  # * `--dest-file` - `sqlmap.dest_file`
  #
  # ### Operating system access:
  #
  # * `--os-cmd` - `sqlmap.os_command`
  # * `--os-shell` - `sqlmap.os_shell`
  # * `--os-pwn` - `sqlmap.os_pwn`
  # * `--priv-esc` - `sqlmap.privilege_escalation`
  # * `--msf-path` - `sqlmap.msf_path`
  # * `--tmp-path` - `sqlmap.tmp_path`
  #
  # ### Windows registry access:
  #
  # * `--reg-read` - `sqlmap.reg_read`
  # * `--reg-add` - `sqlmap.reg_add`
  # * `--reg-del` - `sqlmap.reg_del`
  # * `--reg-key` - `sqlmap.reg_key`
  # * `--reg-value` - `sqlmap.reg_value`
  # * `--reg-data` - `sqlmap.reg_data`
  # * `--reg-type` - `sqlmap.reg_type`
  #
  # ### Miscellaneous:
  #
  # * `-x` - `sqlmap.xml_file`
  # * `-s` - `sqlmap.session_file`
  # * `--flush-session` - `sqlmap.flush_session`
  # * `--eta` - `sqlmap.eta`
  # * `--gpage` - `sqlmap.google_page`
  # * `--update` - `sqlmap.update`
  # * `--save` - `sqlmap.save`
  # * `--batch` - `sqlmap.batch`
  # * `--cleanup` - `sqlmap.cleanup`
  #
  class SQLMapTask < RProgram::Task

    long_option :flag => '--version'
    long_option :flag => '--help'
    short_option :flag => '-v', :name => :verbose

    # Target options:
    short_option :flag => '-d', :name => :direct
    short_option :flag => '-u', :name => :url
    short_option :flag => '-l', :name => :list
    short_option :flag => '-r', :name => :request_file
    short_option :flag => '-g', :name => :google_dork
    short_option :flag => '-c', :name => :config_file

    # Request options:
    long_option :flag => '--method', :equals => true, :name => :request_method
    long_option :flag => '--data', :equals => true, :name => :post_data
    long_option :flag => '--cookie', :equals => true
    long_option :flag => '--cookie-urlencode', :name => :cookie_url_encode
    long_option :flag => '--drop-set-cookie'
    long_option :flag => '--user-agent', :equals => true
    short_option :flag => '-a', :name => :user_agent_file
    long_option :flag => '--referer', :equals => true
    long_option :flag => '--headers', :equals => true
    long_option :flag => '--auth-type', :equals => true
    long_option :flag => '--auth-cred', :equals => true, :separator => ':', :name => :auth_credentials
    long_option :flag => '--auth-cert', :equals => true
    long_option :flag => '--proxy', :equals => true
    long_option :flag => '--ignore-proxy'
    long_option :flag => '--threads', :equals => true
    long_option :flag => '--delay', :equals => true
    long_option :flag => '--timeout', :equals => true
    long_option :flag => '--retries', :equals => true
    long_option :flag => '--scope', :equals => true
    long_option :flag => '--safe-url', :equals => true
    long_option :flag => '--safe-freq', :equals => true, :name => :safe_frequencey

    # Injection options:
    short_option :flag => '-p', :name => :params
    long_option :flag => '--dbms', :equals => true
    long_option :flag => '--os', :equals => true
    long_option :flag => '--prefix', :equals => true
    long_option :flag => '--postfix', :equals => true
    long_option :flag => '--string', :equals => true
    long_option :flag => '--regexp', :equals => true
    long_option :flag => '--excl-str', :equals => true, :name => :exclude_string
    long_option :flag => '--excl-reg', :equals => true, :name => :exclude_regexp
    long_option :flag => '--use-between'

    # Technique options:
    long_option :flag => '--stacked-test'
    long_option :flag => '--time-test'
    long_option :flag => '--time-sec', :equals => true
    long_option :flag => '--union-test'
    long_option :flag => '--union-tech', :name => :union_style
    long_option :flag => '--union-use', :name => :union_use

    # Fingerprint options:
    long_option :flag => '--fingerprint'

    # Enumeration options:
    long_option :flag => '--banner'
    long_option :flag => '--current-user'
    long_option :flag => '--current-db', :name => :current_database
    long_option :flag => '--is-dba'
    long_option :flag => '--users'
    long_option :flag => '--passwords'
    long_option :flag => '--privileges'
    long_option :flag => '--roles'
    long_option :flag => '--dbs', :name => :databases
    long_option :flag => '--tables'
    long_option :flag => '--colums'
    long_option :flag => '--dump'
    long_option :flag => '--dump-all'
    long_option :flag => '--search'
    short_option :flag => '-D', :name => :enumerate_database
    short_option :flag => '-T', :name => :enumerate_table
    short_option :flag => '-C', :name => :enumerate_column
    short_option :flag => '-U', :name => :enumerate_user
    long_option :flag => '--exclude-sysdbs', :name => :exclude_system_databases
    long_option :flag => '--start', :equals => true
    long_option :flag => '--stop', :equals => true
    long_option :flag => '--first', :equals => true
    long_option :flag => '--last', :equals => true
    long_option :flag => '--sql-query', :equals => true
    long_option :flag => '--sql-shell'

    # User-defined function injection options:
    long_option :flag => '--udf-inject'
    long_option :flag => '--shared-lib'

    # File system access options:
    long_option :flag => '--read-file', :equals => true
    long_option :flag => '--write-file', :equals => true
    long_option :flag => '--dest-file', :equals => true

    # Operating system access options:
    long_option :flag => '--os-cmd', :equals => true, :name => :os_command
    long_option :flag => '--os-shell'
    long_option :flag => '--os-pwn'
    long_option :flag => '--os-smbrelay', :name => :os_smb_relay
    long_option :flag => '--os-bof', :name => :os_bof
    long_option :flag => '--priv-esc', :name => :privilege_escalation
    long_option :flag => '--msf-path', :equals => true
    long_option :flag => '--tmp-path', :equals => true

    # Windows registry access options:
    long_option :flag => '--reg-read'
    long_option :flag => '--reg-add'
    long_option :flag => '--reg-del'
    long_option :flag => '--reg-key', :equals => true
    long_option :flag => '--reg-value', :equals => true
    long_option :flag => '--reg-data', :equals => true
    long_option :flag => '--reg-type', :equals => true

    # Miscellaneous options:
    short_option :flag => '-x', :name => :xml_file
    short_option :flag => '-s', :name => :session_file
    long_option :flag => '--flush-session'
    long_option :flag => '--eta'
    long_option :flag => '--gpage', :name => :google_page
    long_option :flag => '--update'
    long_option :flag => '--save'
    long_option :flag => '--batch'
    long_option :flag => '--cleanup'

  end
end
