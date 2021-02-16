module windows.netmanagement;

public import windows.core;
public import windows.com : HRESULT;
public import windows.security : CERT_CONTEXT, SID_NAME_USE;
public import windows.systemservices : BOOL;
public import windows.windowsprogramming : FILETIME;

extern(Windows):


// Enums


enum : int
{
    NetValidateAuthentication = 0x00000001,
    NetValidatePasswordChange = 0x00000002,
    NetValidatePasswordReset  = 0x00000003,
}
alias NET_VALIDATE_PASSWORD_TYPE = int;

enum : int
{
    NetSetupUnknown           = 0x00000000,
    NetSetupMachine           = 0x00000001,
    NetSetupWorkgroup         = 0x00000002,
    NetSetupDomain            = 0x00000003,
    NetSetupNonExistentDomain = 0x00000004,
    NetSetupDnsMachine        = 0x00000005,
}
alias NETSETUP_NAME_TYPE = int;

enum : int
{
    DSREG_UNKNOWN_JOIN   = 0x00000000,
    DSREG_DEVICE_JOIN    = 0x00000001,
    DSREG_WORKPLACE_JOIN = 0x00000002,
}
alias DSREG_JOIN_TYPE = int;

enum : int
{
    NetPrimaryComputerName    = 0x00000000,
    NetAlternateComputerNames = 0x00000001,
    NetAllComputerNames       = 0x00000002,
    NetComputerNameTypeMax    = 0x00000003,
}
alias NET_COMPUTER_NAME_TYPE = int;

enum : int
{
    NetSetupUnknownStatus = 0x00000000,
    NetSetupUnjoined      = 0x00000001,
    NetSetupWorkgroupName = 0x00000002,
    NetSetupDomainName    = 0x00000003,
}
alias NETSETUP_JOIN_STATUS = int;

enum : int
{
    UseTransportType_None = 0x00000000,
    UseTransportType_Wsk  = 0x00000001,
    UseTransportType_Quic = 0x00000002,
}
alias TRANSPORT_TYPE = int;

// Structs


struct USER_INFO_0
{
    const(wchar)* usri0_name;
}

struct USER_INFO_1
{
    const(wchar)* usri1_name;
    const(wchar)* usri1_password;
    uint          usri1_password_age;
    uint          usri1_priv;
    const(wchar)* usri1_home_dir;
    const(wchar)* usri1_comment;
    uint          usri1_flags;
    const(wchar)* usri1_script_path;
}

struct USER_INFO_2
{
    const(wchar)* usri2_name;
    const(wchar)* usri2_password;
    uint          usri2_password_age;
    uint          usri2_priv;
    const(wchar)* usri2_home_dir;
    const(wchar)* usri2_comment;
    uint          usri2_flags;
    const(wchar)* usri2_script_path;
    uint          usri2_auth_flags;
    const(wchar)* usri2_full_name;
    const(wchar)* usri2_usr_comment;
    const(wchar)* usri2_parms;
    const(wchar)* usri2_workstations;
    uint          usri2_last_logon;
    uint          usri2_last_logoff;
    uint          usri2_acct_expires;
    uint          usri2_max_storage;
    uint          usri2_units_per_week;
    ubyte*        usri2_logon_hours;
    uint          usri2_bad_pw_count;
    uint          usri2_num_logons;
    const(wchar)* usri2_logon_server;
    uint          usri2_country_code;
    uint          usri2_code_page;
}

struct USER_INFO_3
{
    const(wchar)* usri3_name;
    const(wchar)* usri3_password;
    uint          usri3_password_age;
    uint          usri3_priv;
    const(wchar)* usri3_home_dir;
    const(wchar)* usri3_comment;
    uint          usri3_flags;
    const(wchar)* usri3_script_path;
    uint          usri3_auth_flags;
    const(wchar)* usri3_full_name;
    const(wchar)* usri3_usr_comment;
    const(wchar)* usri3_parms;
    const(wchar)* usri3_workstations;
    uint          usri3_last_logon;
    uint          usri3_last_logoff;
    uint          usri3_acct_expires;
    uint          usri3_max_storage;
    uint          usri3_units_per_week;
    ubyte*        usri3_logon_hours;
    uint          usri3_bad_pw_count;
    uint          usri3_num_logons;
    const(wchar)* usri3_logon_server;
    uint          usri3_country_code;
    uint          usri3_code_page;
    uint          usri3_user_id;
    uint          usri3_primary_group_id;
    const(wchar)* usri3_profile;
    const(wchar)* usri3_home_dir_drive;
    uint          usri3_password_expired;
}

struct USER_INFO_4
{
    const(wchar)* usri4_name;
    const(wchar)* usri4_password;
    uint          usri4_password_age;
    uint          usri4_priv;
    const(wchar)* usri4_home_dir;
    const(wchar)* usri4_comment;
    uint          usri4_flags;
    const(wchar)* usri4_script_path;
    uint          usri4_auth_flags;
    const(wchar)* usri4_full_name;
    const(wchar)* usri4_usr_comment;
    const(wchar)* usri4_parms;
    const(wchar)* usri4_workstations;
    uint          usri4_last_logon;
    uint          usri4_last_logoff;
    uint          usri4_acct_expires;
    uint          usri4_max_storage;
    uint          usri4_units_per_week;
    ubyte*        usri4_logon_hours;
    uint          usri4_bad_pw_count;
    uint          usri4_num_logons;
    const(wchar)* usri4_logon_server;
    uint          usri4_country_code;
    uint          usri4_code_page;
    void*         usri4_user_sid;
    uint          usri4_primary_group_id;
    const(wchar)* usri4_profile;
    const(wchar)* usri4_home_dir_drive;
    uint          usri4_password_expired;
}

struct USER_INFO_10
{
    const(wchar)* usri10_name;
    const(wchar)* usri10_comment;
    const(wchar)* usri10_usr_comment;
    const(wchar)* usri10_full_name;
}

struct USER_INFO_11
{
    const(wchar)* usri11_name;
    const(wchar)* usri11_comment;
    const(wchar)* usri11_usr_comment;
    const(wchar)* usri11_full_name;
    uint          usri11_priv;
    uint          usri11_auth_flags;
    uint          usri11_password_age;
    const(wchar)* usri11_home_dir;
    const(wchar)* usri11_parms;
    uint          usri11_last_logon;
    uint          usri11_last_logoff;
    uint          usri11_bad_pw_count;
    uint          usri11_num_logons;
    const(wchar)* usri11_logon_server;
    uint          usri11_country_code;
    const(wchar)* usri11_workstations;
    uint          usri11_max_storage;
    uint          usri11_units_per_week;
    ubyte*        usri11_logon_hours;
    uint          usri11_code_page;
}

struct USER_INFO_20
{
    const(wchar)* usri20_name;
    const(wchar)* usri20_full_name;
    const(wchar)* usri20_comment;
    uint          usri20_flags;
    uint          usri20_user_id;
}

struct USER_INFO_21
{
    ubyte[16] usri21_password;
}

struct USER_INFO_22
{
    const(wchar)* usri22_name;
    ubyte[16]     usri22_password;
    uint          usri22_password_age;
    uint          usri22_priv;
    const(wchar)* usri22_home_dir;
    const(wchar)* usri22_comment;
    uint          usri22_flags;
    const(wchar)* usri22_script_path;
    uint          usri22_auth_flags;
    const(wchar)* usri22_full_name;
    const(wchar)* usri22_usr_comment;
    const(wchar)* usri22_parms;
    const(wchar)* usri22_workstations;
    uint          usri22_last_logon;
    uint          usri22_last_logoff;
    uint          usri22_acct_expires;
    uint          usri22_max_storage;
    uint          usri22_units_per_week;
    ubyte*        usri22_logon_hours;
    uint          usri22_bad_pw_count;
    uint          usri22_num_logons;
    const(wchar)* usri22_logon_server;
    uint          usri22_country_code;
    uint          usri22_code_page;
}

struct USER_INFO_23
{
    const(wchar)* usri23_name;
    const(wchar)* usri23_full_name;
    const(wchar)* usri23_comment;
    uint          usri23_flags;
    void*         usri23_user_sid;
}

struct USER_INFO_24
{
    BOOL          usri24_internet_identity;
    uint          usri24_flags;
    const(wchar)* usri24_internet_provider_name;
    const(wchar)* usri24_internet_principal_name;
    void*         usri24_user_sid;
}

struct USER_INFO_1003
{
    const(wchar)* usri1003_password;
}

struct USER_INFO_1005
{
    uint usri1005_priv;
}

struct USER_INFO_1006
{
    const(wchar)* usri1006_home_dir;
}

struct USER_INFO_1007
{
    const(wchar)* usri1007_comment;
}

struct USER_INFO_1008
{
    uint usri1008_flags;
}

struct USER_INFO_1009
{
    const(wchar)* usri1009_script_path;
}

struct USER_INFO_1010
{
    uint usri1010_auth_flags;
}

struct USER_INFO_1011
{
    const(wchar)* usri1011_full_name;
}

struct USER_INFO_1012
{
    const(wchar)* usri1012_usr_comment;
}

struct USER_INFO_1013
{
    const(wchar)* usri1013_parms;
}

struct USER_INFO_1014
{
    const(wchar)* usri1014_workstations;
}

struct USER_INFO_1017
{
    uint usri1017_acct_expires;
}

struct USER_INFO_1018
{
    uint usri1018_max_storage;
}

struct USER_INFO_1020
{
    uint   usri1020_units_per_week;
    ubyte* usri1020_logon_hours;
}

struct USER_INFO_1023
{
    const(wchar)* usri1023_logon_server;
}

struct USER_INFO_1024
{
    uint usri1024_country_code;
}

struct USER_INFO_1025
{
    uint usri1025_code_page;
}

struct USER_INFO_1051
{
    uint usri1051_primary_group_id;
}

struct USER_INFO_1052
{
    const(wchar)* usri1052_profile;
}

struct USER_INFO_1053
{
    const(wchar)* usri1053_home_dir_drive;
}

struct USER_MODALS_INFO_0
{
    uint usrmod0_min_passwd_len;
    uint usrmod0_max_passwd_age;
    uint usrmod0_min_passwd_age;
    uint usrmod0_force_logoff;
    uint usrmod0_password_hist_len;
}

struct USER_MODALS_INFO_1
{
    uint          usrmod1_role;
    const(wchar)* usrmod1_primary;
}

struct USER_MODALS_INFO_2
{
    const(wchar)* usrmod2_domain_name;
    void*         usrmod2_domain_id;
}

struct USER_MODALS_INFO_3
{
    uint usrmod3_lockout_duration;
    uint usrmod3_lockout_observation_window;
    uint usrmod3_lockout_threshold;
}

struct USER_MODALS_INFO_1001
{
    uint usrmod1001_min_passwd_len;
}

struct USER_MODALS_INFO_1002
{
    uint usrmod1002_max_passwd_age;
}

struct USER_MODALS_INFO_1003
{
    uint usrmod1003_min_passwd_age;
}

struct USER_MODALS_INFO_1004
{
    uint usrmod1004_force_logoff;
}

struct USER_MODALS_INFO_1005
{
    uint usrmod1005_password_hist_len;
}

struct USER_MODALS_INFO_1006
{
    uint usrmod1006_role;
}

struct USER_MODALS_INFO_1007
{
    const(wchar)* usrmod1007_primary;
}

struct GROUP_INFO_0
{
    const(wchar)* grpi0_name;
}

struct GROUP_INFO_1
{
    const(wchar)* grpi1_name;
    const(wchar)* grpi1_comment;
}

struct GROUP_INFO_2
{
    const(wchar)* grpi2_name;
    const(wchar)* grpi2_comment;
    uint          grpi2_group_id;
    uint          grpi2_attributes;
}

struct GROUP_INFO_3
{
    const(wchar)* grpi3_name;
    const(wchar)* grpi3_comment;
    void*         grpi3_group_sid;
    uint          grpi3_attributes;
}

struct GROUP_INFO_1002
{
    const(wchar)* grpi1002_comment;
}

struct GROUP_INFO_1005
{
    uint grpi1005_attributes;
}

struct GROUP_USERS_INFO_0
{
    const(wchar)* grui0_name;
}

struct GROUP_USERS_INFO_1
{
    const(wchar)* grui1_name;
    uint          grui1_attributes;
}

struct LOCALGROUP_INFO_0
{
    const(wchar)* lgrpi0_name;
}

struct LOCALGROUP_INFO_1
{
    const(wchar)* lgrpi1_name;
    const(wchar)* lgrpi1_comment;
}

struct LOCALGROUP_INFO_1002
{
    const(wchar)* lgrpi1002_comment;
}

struct LOCALGROUP_MEMBERS_INFO_0
{
    void* lgrmi0_sid;
}

struct LOCALGROUP_MEMBERS_INFO_1
{
    void*         lgrmi1_sid;
    SID_NAME_USE  lgrmi1_sidusage;
    const(wchar)* lgrmi1_name;
}

struct LOCALGROUP_MEMBERS_INFO_2
{
    void*         lgrmi2_sid;
    SID_NAME_USE  lgrmi2_sidusage;
    const(wchar)* lgrmi2_domainandname;
}

struct LOCALGROUP_MEMBERS_INFO_3
{
    const(wchar)* lgrmi3_domainandname;
}

struct LOCALGROUP_USERS_INFO_0
{
    const(wchar)* lgrui0_name;
}

struct NET_DISPLAY_USER
{
    const(wchar)* usri1_name;
    const(wchar)* usri1_comment;
    uint          usri1_flags;
    const(wchar)* usri1_full_name;
    uint          usri1_user_id;
    uint          usri1_next_index;
}

struct NET_DISPLAY_MACHINE
{
    const(wchar)* usri2_name;
    const(wchar)* usri2_comment;
    uint          usri2_flags;
    uint          usri2_user_id;
    uint          usri2_next_index;
}

struct NET_DISPLAY_GROUP
{
    const(wchar)* grpi3_name;
    const(wchar)* grpi3_comment;
    uint          grpi3_group_id;
    uint          grpi3_attributes;
    uint          grpi3_next_index;
}

struct ACCESS_INFO_0
{
    const(wchar)* acc0_resource_name;
}

struct ACCESS_INFO_1
{
    const(wchar)* acc1_resource_name;
    uint          acc1_attr;
    uint          acc1_count;
}

struct ACCESS_INFO_1002
{
    uint acc1002_attr;
}

struct ACCESS_LIST
{
    const(wchar)* acl_ugname;
    uint          acl_access;
}

struct NET_VALIDATE_PASSWORD_HASH
{
    uint   Length;
    ubyte* Hash;
}

struct NET_VALIDATE_PERSISTED_FIELDS
{
    uint     PresentFields;
    FILETIME PasswordLastSet;
    FILETIME BadPasswordTime;
    FILETIME LockoutTime;
    uint     BadPasswordCount;
    uint     PasswordHistoryLength;
    NET_VALIDATE_PASSWORD_HASH* PasswordHistory;
}

struct NET_VALIDATE_OUTPUT_ARG
{
    NET_VALIDATE_PERSISTED_FIELDS ChangedPersistedFields;
    uint ValidationStatus;
}

struct NET_VALIDATE_AUTHENTICATION_INPUT_ARG
{
    NET_VALIDATE_PERSISTED_FIELDS InputPersistedFields;
    ubyte PasswordMatched;
}

struct NET_VALIDATE_PASSWORD_CHANGE_INPUT_ARG
{
    NET_VALIDATE_PERSISTED_FIELDS InputPersistedFields;
    const(wchar)* ClearPassword;
    const(wchar)* UserAccountName;
    NET_VALIDATE_PASSWORD_HASH HashedPassword;
    ubyte         PasswordMatch;
}

struct NET_VALIDATE_PASSWORD_RESET_INPUT_ARG
{
    NET_VALIDATE_PERSISTED_FIELDS InputPersistedFields;
    const(wchar)* ClearPassword;
    const(wchar)* UserAccountName;
    NET_VALIDATE_PASSWORD_HASH HashedPassword;
    ubyte         PasswordMustChangeAtNextLogon;
    ubyte         ClearLockout;
}

struct DSREG_USER_INFO
{
    const(wchar)* pszUserEmail;
    const(wchar)* pszUserKeyId;
    const(wchar)* pszUserKeyName;
}

struct DSREG_JOIN_INFO
{
    DSREG_JOIN_TYPE  joinType;
    CERT_CONTEXT*    pJoinCertificate;
    const(wchar)*    pszDeviceId;
    const(wchar)*    pszIdpDomain;
    const(wchar)*    pszTenantId;
    const(wchar)*    pszJoinUserEmail;
    const(wchar)*    pszTenantDisplayName;
    const(wchar)*    pszMdmEnrollmentUrl;
    const(wchar)*    pszMdmTermsOfUseUrl;
    const(wchar)*    pszMdmComplianceUrl;
    const(wchar)*    pszUserSettingSyncUrl;
    DSREG_USER_INFO* pUserInfo;
}

struct NETSETUP_PROVISIONING_PARAMS
{
    uint          dwVersion;
    const(wchar)* lpDomain;
    const(wchar)* lpHostName;
    const(wchar)* lpMachineAccountOU;
    const(wchar)* lpDcName;
    uint          dwProvisionOptions;
    ushort**      aCertTemplateNames;
    uint          cCertTemplateNames;
    ushort**      aMachinePolicyNames;
    uint          cMachinePolicyNames;
    ushort**      aMachinePolicyPaths;
    uint          cMachinePolicyPaths;
    const(wchar)* lpNetbiosName;
    const(wchar)* lpSiteName;
    const(wchar)* lpPrimaryDNSDomain;
}

struct STD_ALERT
{
    uint       alrt_timestamp;
    ushort[17] alrt_eventname;
    ushort[81] alrt_servicename;
}

struct ADMIN_OTHER_INFO
{
    uint alrtad_errcode;
    uint alrtad_numstrings;
}

struct ERRLOG_OTHER_INFO
{
    uint alrter_errcode;
    uint alrter_offset;
}

struct PRINT_OTHER_INFO
{
    uint alrtpr_jobid;
    uint alrtpr_status;
    uint alrtpr_submitted;
    uint alrtpr_size;
}

struct USER_OTHER_INFO
{
    uint alrtus_errcode;
    uint alrtus_numstrings;
}

struct HLOG
{
    uint time;
    uint last_flags;
    uint offset;
    uint rec_offset;
}

struct AUDIT_ENTRY
{
    uint ae_len;
    uint ae_reserved;
    uint ae_time;
    uint ae_type;
    uint ae_data_offset;
    uint ae_data_size;
}

struct AE_SRVSTATUS
{
    uint ae_sv_status;
}

struct AE_SESSLOGON
{
    uint ae_so_compname;
    uint ae_so_username;
    uint ae_so_privilege;
}

struct AE_SESSLOGOFF
{
    uint ae_sf_compname;
    uint ae_sf_username;
    uint ae_sf_reason;
}

struct AE_SESSPWERR
{
    uint ae_sp_compname;
    uint ae_sp_username;
}

struct AE_CONNSTART
{
    uint ae_ct_compname;
    uint ae_ct_username;
    uint ae_ct_netname;
    uint ae_ct_connid;
}

struct AE_CONNSTOP
{
    uint ae_cp_compname;
    uint ae_cp_username;
    uint ae_cp_netname;
    uint ae_cp_connid;
    uint ae_cp_reason;
}

struct AE_CONNREJ
{
    uint ae_cr_compname;
    uint ae_cr_username;
    uint ae_cr_netname;
    uint ae_cr_reason;
}

struct AE_RESACCESS
{
    uint ae_ra_compname;
    uint ae_ra_username;
    uint ae_ra_resname;
    uint ae_ra_operation;
    uint ae_ra_returncode;
    uint ae_ra_restype;
    uint ae_ra_fileid;
}

struct AE_RESACCESSREJ
{
    uint ae_rr_compname;
    uint ae_rr_username;
    uint ae_rr_resname;
    uint ae_rr_operation;
}

struct AE_CLOSEFILE
{
    uint ae_cf_compname;
    uint ae_cf_username;
    uint ae_cf_resname;
    uint ae_cf_fileid;
    uint ae_cf_duration;
    uint ae_cf_reason;
}

struct AE_SERVICESTAT
{
    uint ae_ss_compname;
    uint ae_ss_username;
    uint ae_ss_svcname;
    uint ae_ss_status;
    uint ae_ss_code;
    uint ae_ss_text;
    uint ae_ss_returnval;
}

struct AE_ACLMOD
{
    uint ae_am_compname;
    uint ae_am_username;
    uint ae_am_resname;
    uint ae_am_action;
    uint ae_am_datalen;
}

struct AE_UASMOD
{
    uint ae_um_compname;
    uint ae_um_username;
    uint ae_um_resname;
    uint ae_um_rectype;
    uint ae_um_action;
    uint ae_um_datalen;
}

struct AE_NETLOGON
{
    uint ae_no_compname;
    uint ae_no_username;
    uint ae_no_privilege;
    uint ae_no_authflags;
}

struct AE_NETLOGOFF
{
    uint ae_nf_compname;
    uint ae_nf_username;
    uint ae_nf_reserved1;
    uint ae_nf_reserved2;
}

struct AE_ACCLIM
{
    uint ae_al_compname;
    uint ae_al_username;
    uint ae_al_resname;
    uint ae_al_limit;
}

struct AE_LOCKOUT
{
    uint ae_lk_compname;
    uint ae_lk_username;
    uint ae_lk_action;
    uint ae_lk_bad_pw_count;
}

struct AE_GENERIC
{
    uint ae_ge_msgfile;
    uint ae_ge_msgnum;
    uint ae_ge_params;
    uint ae_ge_param1;
    uint ae_ge_param2;
    uint ae_ge_param3;
    uint ae_ge_param4;
    uint ae_ge_param5;
    uint ae_ge_param6;
    uint ae_ge_param7;
    uint ae_ge_param8;
    uint ae_ge_param9;
}

struct CONFIG_INFO_0
{
    const(wchar)* cfgi0_key;
    const(wchar)* cfgi0_data;
}

struct ERROR_LOG
{
    uint          el_len;
    uint          el_reserved;
    uint          el_time;
    uint          el_error;
    const(wchar)* el_name;
    const(wchar)* el_text;
    ubyte*        el_data;
    uint          el_data_size;
    uint          el_nstrings;
}

struct MSG_INFO_0
{
    const(wchar)* msgi0_name;
}

struct MSG_INFO_1
{
    const(wchar)* msgi1_name;
    uint          msgi1_forward_flag;
    const(wchar)* msgi1_forward;
}

struct TIME_OF_DAY_INFO
{
    uint tod_elapsedt;
    uint tod_msecs;
    uint tod_hours;
    uint tod_mins;
    uint tod_secs;
    uint tod_hunds;
    int  tod_timezone;
    uint tod_tinterval;
    uint tod_day;
    uint tod_month;
    uint tod_year;
    uint tod_weekday;
}

struct AT_INFO
{
    size_t        JobTime;
    uint          DaysOfMonth;
    ubyte         DaysOfWeek;
    ubyte         Flags;
    const(wchar)* Command;
}

struct AT_ENUM
{
    uint          JobId;
    size_t        JobTime;
    uint          DaysOfMonth;
    ubyte         DaysOfWeek;
    ubyte         Flags;
    const(wchar)* Command;
}

struct SERVER_INFO_100
{
    uint          sv100_platform_id;
    const(wchar)* sv100_name;
}

struct SERVER_INFO_101
{
    uint          sv101_platform_id;
    const(wchar)* sv101_name;
    uint          sv101_version_major;
    uint          sv101_version_minor;
    uint          sv101_type;
    const(wchar)* sv101_comment;
}

struct SERVER_INFO_102
{
    uint          sv102_platform_id;
    const(wchar)* sv102_name;
    uint          sv102_version_major;
    uint          sv102_version_minor;
    uint          sv102_type;
    const(wchar)* sv102_comment;
    uint          sv102_users;
    int           sv102_disc;
    BOOL          sv102_hidden;
    uint          sv102_announce;
    uint          sv102_anndelta;
    uint          sv102_licenses;
    const(wchar)* sv102_userpath;
}

struct SERVER_INFO_103
{
    uint          sv103_platform_id;
    const(wchar)* sv103_name;
    uint          sv103_version_major;
    uint          sv103_version_minor;
    uint          sv103_type;
    const(wchar)* sv103_comment;
    uint          sv103_users;
    int           sv103_disc;
    BOOL          sv103_hidden;
    uint          sv103_announce;
    uint          sv103_anndelta;
    uint          sv103_licenses;
    const(wchar)* sv103_userpath;
    uint          sv103_capabilities;
}

struct SERVER_INFO_402
{
    uint          sv402_ulist_mtime;
    uint          sv402_glist_mtime;
    uint          sv402_alist_mtime;
    const(wchar)* sv402_alerts;
    uint          sv402_security;
    uint          sv402_numadmin;
    uint          sv402_lanmask;
    const(wchar)* sv402_guestacct;
    uint          sv402_chdevs;
    uint          sv402_chdevq;
    uint          sv402_chdevjobs;
    uint          sv402_connections;
    uint          sv402_shares;
    uint          sv402_openfiles;
    uint          sv402_sessopens;
    uint          sv402_sessvcs;
    uint          sv402_sessreqs;
    uint          sv402_opensearch;
    uint          sv402_activelocks;
    uint          sv402_numreqbuf;
    uint          sv402_sizreqbuf;
    uint          sv402_numbigbuf;
    uint          sv402_numfiletasks;
    uint          sv402_alertsched;
    uint          sv402_erroralert;
    uint          sv402_logonalert;
    uint          sv402_accessalert;
    uint          sv402_diskalert;
    uint          sv402_netioalert;
    uint          sv402_maxauditsz;
    const(wchar)* sv402_srvheuristics;
}

struct SERVER_INFO_403
{
    uint          sv403_ulist_mtime;
    uint          sv403_glist_mtime;
    uint          sv403_alist_mtime;
    const(wchar)* sv403_alerts;
    uint          sv403_security;
    uint          sv403_numadmin;
    uint          sv403_lanmask;
    const(wchar)* sv403_guestacct;
    uint          sv403_chdevs;
    uint          sv403_chdevq;
    uint          sv403_chdevjobs;
    uint          sv403_connections;
    uint          sv403_shares;
    uint          sv403_openfiles;
    uint          sv403_sessopens;
    uint          sv403_sessvcs;
    uint          sv403_sessreqs;
    uint          sv403_opensearch;
    uint          sv403_activelocks;
    uint          sv403_numreqbuf;
    uint          sv403_sizreqbuf;
    uint          sv403_numbigbuf;
    uint          sv403_numfiletasks;
    uint          sv403_alertsched;
    uint          sv403_erroralert;
    uint          sv403_logonalert;
    uint          sv403_accessalert;
    uint          sv403_diskalert;
    uint          sv403_netioalert;
    uint          sv403_maxauditsz;
    const(wchar)* sv403_srvheuristics;
    uint          sv403_auditedevents;
    uint          sv403_autoprofile;
    const(wchar)* sv403_autopath;
}

struct SERVER_INFO_502
{
    uint sv502_sessopens;
    uint sv502_sessvcs;
    uint sv502_opensearch;
    uint sv502_sizreqbuf;
    uint sv502_initworkitems;
    uint sv502_maxworkitems;
    uint sv502_rawworkitems;
    uint sv502_irpstacksize;
    uint sv502_maxrawbuflen;
    uint sv502_sessusers;
    uint sv502_sessconns;
    uint sv502_maxpagedmemoryusage;
    uint sv502_maxnonpagedmemoryusage;
    BOOL sv502_enablesoftcompat;
    BOOL sv502_enableforcedlogoff;
    BOOL sv502_timesource;
    BOOL sv502_acceptdownlevelapis;
    BOOL sv502_lmannounce;
}

struct SERVER_INFO_503
{
    uint          sv503_sessopens;
    uint          sv503_sessvcs;
    uint          sv503_opensearch;
    uint          sv503_sizreqbuf;
    uint          sv503_initworkitems;
    uint          sv503_maxworkitems;
    uint          sv503_rawworkitems;
    uint          sv503_irpstacksize;
    uint          sv503_maxrawbuflen;
    uint          sv503_sessusers;
    uint          sv503_sessconns;
    uint          sv503_maxpagedmemoryusage;
    uint          sv503_maxnonpagedmemoryusage;
    BOOL          sv503_enablesoftcompat;
    BOOL          sv503_enableforcedlogoff;
    BOOL          sv503_timesource;
    BOOL          sv503_acceptdownlevelapis;
    BOOL          sv503_lmannounce;
    const(wchar)* sv503_domain;
    uint          sv503_maxcopyreadlen;
    uint          sv503_maxcopywritelen;
    uint          sv503_minkeepsearch;
    uint          sv503_maxkeepsearch;
    uint          sv503_minkeepcomplsearch;
    uint          sv503_maxkeepcomplsearch;
    uint          sv503_threadcountadd;
    uint          sv503_numblockthreads;
    uint          sv503_scavtimeout;
    uint          sv503_minrcvqueue;
    uint          sv503_minfreeworkitems;
    uint          sv503_xactmemsize;
    uint          sv503_threadpriority;
    uint          sv503_maxmpxct;
    uint          sv503_oplockbreakwait;
    uint          sv503_oplockbreakresponsewait;
    BOOL          sv503_enableoplocks;
    BOOL          sv503_enableoplockforceclose;
    BOOL          sv503_enablefcbopens;
    BOOL          sv503_enableraw;
    BOOL          sv503_enablesharednetdrives;
    uint          sv503_minfreeconnections;
    uint          sv503_maxfreeconnections;
}

struct SERVER_INFO_599
{
    uint          sv599_sessopens;
    uint          sv599_sessvcs;
    uint          sv599_opensearch;
    uint          sv599_sizreqbuf;
    uint          sv599_initworkitems;
    uint          sv599_maxworkitems;
    uint          sv599_rawworkitems;
    uint          sv599_irpstacksize;
    uint          sv599_maxrawbuflen;
    uint          sv599_sessusers;
    uint          sv599_sessconns;
    uint          sv599_maxpagedmemoryusage;
    uint          sv599_maxnonpagedmemoryusage;
    BOOL          sv599_enablesoftcompat;
    BOOL          sv599_enableforcedlogoff;
    BOOL          sv599_timesource;
    BOOL          sv599_acceptdownlevelapis;
    BOOL          sv599_lmannounce;
    const(wchar)* sv599_domain;
    uint          sv599_maxcopyreadlen;
    uint          sv599_maxcopywritelen;
    uint          sv599_minkeepsearch;
    uint          sv599_maxkeepsearch;
    uint          sv599_minkeepcomplsearch;
    uint          sv599_maxkeepcomplsearch;
    uint          sv599_threadcountadd;
    uint          sv599_numblockthreads;
    uint          sv599_scavtimeout;
    uint          sv599_minrcvqueue;
    uint          sv599_minfreeworkitems;
    uint          sv599_xactmemsize;
    uint          sv599_threadpriority;
    uint          sv599_maxmpxct;
    uint          sv599_oplockbreakwait;
    uint          sv599_oplockbreakresponsewait;
    BOOL          sv599_enableoplocks;
    BOOL          sv599_enableoplockforceclose;
    BOOL          sv599_enablefcbopens;
    BOOL          sv599_enableraw;
    BOOL          sv599_enablesharednetdrives;
    uint          sv599_minfreeconnections;
    uint          sv599_maxfreeconnections;
    uint          sv599_initsesstable;
    uint          sv599_initconntable;
    uint          sv599_initfiletable;
    uint          sv599_initsearchtable;
    uint          sv599_alertschedule;
    uint          sv599_errorthreshold;
    uint          sv599_networkerrorthreshold;
    uint          sv599_diskspacethreshold;
    uint          sv599_reserved;
    uint          sv599_maxlinkdelay;
    uint          sv599_minlinkthroughput;
    uint          sv599_linkinfovalidtime;
    uint          sv599_scavqosinfoupdatetime;
    uint          sv599_maxworkitemidletime;
}

struct SERVER_INFO_598
{
    uint sv598_maxrawworkitems;
    uint sv598_maxthreadsperqueue;
    uint sv598_producttype;
    uint sv598_serversize;
    uint sv598_connectionlessautodisc;
    uint sv598_sharingviolationretries;
    uint sv598_sharingviolationdelay;
    uint sv598_maxglobalopensearch;
    uint sv598_removeduplicatesearches;
    uint sv598_lockviolationoffset;
    uint sv598_lockviolationdelay;
    uint sv598_mdlreadswitchover;
    uint sv598_cachedopenlimit;
    uint sv598_otherqueueaffinity;
    BOOL sv598_restrictnullsessaccess;
    BOOL sv598_enablewfw311directipx;
    uint sv598_queuesamplesecs;
    uint sv598_balancecount;
    uint sv598_preferredaffinity;
    uint sv598_maxfreerfcbs;
    uint sv598_maxfreemfcbs;
    uint sv598_maxfreelfcbs;
    uint sv598_maxfreepagedpoolchunks;
    uint sv598_minpagedpoolchunksize;
    uint sv598_maxpagedpoolchunksize;
    BOOL sv598_sendsfrompreferredprocessor;
    uint sv598_cacheddirectorylimit;
    uint sv598_maxcopylength;
    BOOL sv598_enablecompression;
    BOOL sv598_autosharewks;
    BOOL sv598_autoshareserver;
    BOOL sv598_enablesecuritysignature;
    BOOL sv598_requiresecuritysignature;
    uint sv598_minclientbuffersize;
    GUID sv598_serverguid;
    uint sv598_ConnectionNoSessionsTimeout;
    uint sv598_IdleThreadTimeOut;
    BOOL sv598_enableW9xsecuritysignature;
    BOOL sv598_enforcekerberosreauthentication;
    BOOL sv598_disabledos;
    uint sv598_lowdiskspaceminimum;
    BOOL sv598_disablestrictnamechecking;
    BOOL sv598_enableauthenticateusersharing;
}

struct SERVER_INFO_1005
{
    const(wchar)* sv1005_comment;
}

struct SERVER_INFO_1107
{
    uint sv1107_users;
}

struct SERVER_INFO_1010
{
    int sv1010_disc;
}

struct SERVER_INFO_1016
{
    BOOL sv1016_hidden;
}

struct SERVER_INFO_1017
{
    uint sv1017_announce;
}

struct SERVER_INFO_1018
{
    uint sv1018_anndelta;
}

struct SERVER_INFO_1501
{
    uint sv1501_sessopens;
}

struct SERVER_INFO_1502
{
    uint sv1502_sessvcs;
}

struct SERVER_INFO_1503
{
    uint sv1503_opensearch;
}

struct SERVER_INFO_1506
{
    uint sv1506_maxworkitems;
}

struct SERVER_INFO_1509
{
    uint sv1509_maxrawbuflen;
}

struct SERVER_INFO_1510
{
    uint sv1510_sessusers;
}

struct SERVER_INFO_1511
{
    uint sv1511_sessconns;
}

struct SERVER_INFO_1512
{
    uint sv1512_maxnonpagedmemoryusage;
}

struct SERVER_INFO_1513
{
    uint sv1513_maxpagedmemoryusage;
}

struct SERVER_INFO_1514
{
    BOOL sv1514_enablesoftcompat;
}

struct SERVER_INFO_1515
{
    BOOL sv1515_enableforcedlogoff;
}

struct SERVER_INFO_1516
{
    BOOL sv1516_timesource;
}

struct SERVER_INFO_1518
{
    BOOL sv1518_lmannounce;
}

struct SERVER_INFO_1520
{
    uint sv1520_maxcopyreadlen;
}

struct SERVER_INFO_1521
{
    uint sv1521_maxcopywritelen;
}

struct SERVER_INFO_1522
{
    uint sv1522_minkeepsearch;
}

struct SERVER_INFO_1523
{
    uint sv1523_maxkeepsearch;
}

struct SERVER_INFO_1524
{
    uint sv1524_minkeepcomplsearch;
}

struct SERVER_INFO_1525
{
    uint sv1525_maxkeepcomplsearch;
}

struct SERVER_INFO_1528
{
    uint sv1528_scavtimeout;
}

struct SERVER_INFO_1529
{
    uint sv1529_minrcvqueue;
}

struct SERVER_INFO_1530
{
    uint sv1530_minfreeworkitems;
}

struct SERVER_INFO_1533
{
    uint sv1533_maxmpxct;
}

struct SERVER_INFO_1534
{
    uint sv1534_oplockbreakwait;
}

struct SERVER_INFO_1535
{
    uint sv1535_oplockbreakresponsewait;
}

struct SERVER_INFO_1536
{
    BOOL sv1536_enableoplocks;
}

struct SERVER_INFO_1537
{
    BOOL sv1537_enableoplockforceclose;
}

struct SERVER_INFO_1538
{
    BOOL sv1538_enablefcbopens;
}

struct SERVER_INFO_1539
{
    BOOL sv1539_enableraw;
}

struct SERVER_INFO_1540
{
    BOOL sv1540_enablesharednetdrives;
}

struct SERVER_INFO_1541
{
    BOOL sv1541_minfreeconnections;
}

struct SERVER_INFO_1542
{
    BOOL sv1542_maxfreeconnections;
}

struct SERVER_INFO_1543
{
    uint sv1543_initsesstable;
}

struct SERVER_INFO_1544
{
    uint sv1544_initconntable;
}

struct SERVER_INFO_1545
{
    uint sv1545_initfiletable;
}

struct SERVER_INFO_1546
{
    uint sv1546_initsearchtable;
}

struct SERVER_INFO_1547
{
    uint sv1547_alertschedule;
}

struct SERVER_INFO_1548
{
    uint sv1548_errorthreshold;
}

struct SERVER_INFO_1549
{
    uint sv1549_networkerrorthreshold;
}

struct SERVER_INFO_1550
{
    uint sv1550_diskspacethreshold;
}

struct SERVER_INFO_1552
{
    uint sv1552_maxlinkdelay;
}

struct SERVER_INFO_1553
{
    uint sv1553_minlinkthroughput;
}

struct SERVER_INFO_1554
{
    uint sv1554_linkinfovalidtime;
}

struct SERVER_INFO_1555
{
    uint sv1555_scavqosinfoupdatetime;
}

struct SERVER_INFO_1556
{
    uint sv1556_maxworkitemidletime;
}

struct SERVER_INFO_1557
{
    uint sv1557_maxrawworkitems;
}

struct SERVER_INFO_1560
{
    uint sv1560_producttype;
}

struct SERVER_INFO_1561
{
    uint sv1561_serversize;
}

struct SERVER_INFO_1562
{
    uint sv1562_connectionlessautodisc;
}

struct SERVER_INFO_1563
{
    uint sv1563_sharingviolationretries;
}

struct SERVER_INFO_1564
{
    uint sv1564_sharingviolationdelay;
}

struct SERVER_INFO_1565
{
    uint sv1565_maxglobalopensearch;
}

struct SERVER_INFO_1566
{
    BOOL sv1566_removeduplicatesearches;
}

struct SERVER_INFO_1567
{
    uint sv1567_lockviolationretries;
}

struct SERVER_INFO_1568
{
    uint sv1568_lockviolationoffset;
}

struct SERVER_INFO_1569
{
    uint sv1569_lockviolationdelay;
}

struct SERVER_INFO_1570
{
    uint sv1570_mdlreadswitchover;
}

struct SERVER_INFO_1571
{
    uint sv1571_cachedopenlimit;
}

struct SERVER_INFO_1572
{
    uint sv1572_criticalthreads;
}

struct SERVER_INFO_1573
{
    uint sv1573_restrictnullsessaccess;
}

struct SERVER_INFO_1574
{
    uint sv1574_enablewfw311directipx;
}

struct SERVER_INFO_1575
{
    uint sv1575_otherqueueaffinity;
}

struct SERVER_INFO_1576
{
    uint sv1576_queuesamplesecs;
}

struct SERVER_INFO_1577
{
    uint sv1577_balancecount;
}

struct SERVER_INFO_1578
{
    uint sv1578_preferredaffinity;
}

struct SERVER_INFO_1579
{
    uint sv1579_maxfreerfcbs;
}

struct SERVER_INFO_1580
{
    uint sv1580_maxfreemfcbs;
}

struct SERVER_INFO_1581
{
    uint sv1581_maxfreemlcbs;
}

struct SERVER_INFO_1582
{
    uint sv1582_maxfreepagedpoolchunks;
}

struct SERVER_INFO_1583
{
    uint sv1583_minpagedpoolchunksize;
}

struct SERVER_INFO_1584
{
    uint sv1584_maxpagedpoolchunksize;
}

struct SERVER_INFO_1585
{
    BOOL sv1585_sendsfrompreferredprocessor;
}

struct SERVER_INFO_1586
{
    uint sv1586_maxthreadsperqueue;
}

struct SERVER_INFO_1587
{
    uint sv1587_cacheddirectorylimit;
}

struct SERVER_INFO_1588
{
    uint sv1588_maxcopylength;
}

struct SERVER_INFO_1590
{
    uint sv1590_enablecompression;
}

struct SERVER_INFO_1591
{
    uint sv1591_autosharewks;
}

struct SERVER_INFO_1592
{
    uint sv1592_autosharewks;
}

struct SERVER_INFO_1593
{
    uint sv1593_enablesecuritysignature;
}

struct SERVER_INFO_1594
{
    uint sv1594_requiresecuritysignature;
}

struct SERVER_INFO_1595
{
    uint sv1595_minclientbuffersize;
}

struct SERVER_INFO_1596
{
    uint sv1596_ConnectionNoSessionsTimeout;
}

struct SERVER_INFO_1597
{
    uint sv1597_IdleThreadTimeOut;
}

struct SERVER_INFO_1598
{
    uint sv1598_enableW9xsecuritysignature;
}

struct SERVER_INFO_1599
{
    ubyte sv1598_enforcekerberosreauthentication;
}

struct SERVER_INFO_1600
{
    ubyte sv1598_disabledos;
}

struct SERVER_INFO_1601
{
    uint sv1598_lowdiskspaceminimum;
}

struct SERVER_INFO_1602
{
    BOOL sv_1598_disablestrictnamechecking;
}

struct SERVER_TRANSPORT_INFO_0
{
    uint          svti0_numberofvcs;
    const(wchar)* svti0_transportname;
    ubyte*        svti0_transportaddress;
    uint          svti0_transportaddresslength;
    const(wchar)* svti0_networkaddress;
}

struct SERVER_TRANSPORT_INFO_1
{
    uint          svti1_numberofvcs;
    const(wchar)* svti1_transportname;
    ubyte*        svti1_transportaddress;
    uint          svti1_transportaddresslength;
    const(wchar)* svti1_networkaddress;
    const(wchar)* svti1_domain;
}

struct SERVER_TRANSPORT_INFO_2
{
    uint          svti2_numberofvcs;
    const(wchar)* svti2_transportname;
    ubyte*        svti2_transportaddress;
    uint          svti2_transportaddresslength;
    const(wchar)* svti2_networkaddress;
    const(wchar)* svti2_domain;
    uint          svti2_flags;
}

struct SERVER_TRANSPORT_INFO_3
{
    uint          svti3_numberofvcs;
    const(wchar)* svti3_transportname;
    ubyte*        svti3_transportaddress;
    uint          svti3_transportaddresslength;
    const(wchar)* svti3_networkaddress;
    const(wchar)* svti3_domain;
    uint          svti3_flags;
    uint          svti3_passwordlength;
    ubyte[256]    svti3_password;
}

struct SERVICE_INFO_0
{
    const(wchar)* svci0_name;
}

struct SERVICE_INFO_1
{
    const(wchar)* svci1_name;
    uint          svci1_status;
    uint          svci1_code;
    uint          svci1_pid;
}

struct SERVICE_INFO_2
{
    const(wchar)* svci2_name;
    uint          svci2_status;
    uint          svci2_code;
    uint          svci2_pid;
    const(wchar)* svci2_text;
    uint          svci2_specific_error;
    const(wchar)* svci2_display_name;
}

struct USE_INFO_0
{
    const(wchar)* ui0_local;
    const(wchar)* ui0_remote;
}

struct USE_INFO_1
{
    const(wchar)* ui1_local;
    const(wchar)* ui1_remote;
    const(wchar)* ui1_password;
    uint          ui1_status;
    uint          ui1_asg_type;
    uint          ui1_refcount;
    uint          ui1_usecount;
}

struct USE_INFO_2
{
    const(wchar)* ui2_local;
    const(wchar)* ui2_remote;
    const(wchar)* ui2_password;
    uint          ui2_status;
    uint          ui2_asg_type;
    uint          ui2_refcount;
    uint          ui2_usecount;
    const(wchar)* ui2_username;
    const(wchar)* ui2_domainname;
}

struct USE_INFO_3
{
    USE_INFO_2 ui3_ui2;
    uint       ui3_flags;
}

struct USE_INFO_4
{
    USE_INFO_3 ui4_ui3;
    uint       ui4_auth_identity_length;
    ubyte*     ui4_auth_identity;
}

struct USE_INFO_5
{
    USE_INFO_3 ui4_ui3;
    uint       ui4_auth_identity_length;
    ubyte*     ui4_auth_identity;
    uint       ui5_security_descriptor_length;
    ubyte*     ui5_security_descriptor;
    uint       ui5_use_options_length;
    ubyte*     ui5_use_options;
}

struct USE_OPTION_GENERIC
{
    uint   Tag;
    ushort Length;
    ushort Reserved;
}

struct USE_OPTION_DEFERRED_CONNECTION_PARAMETERS
{
    uint   Tag;
    ushort Length;
    ushort Reserved;
}

struct TRANSPORT_INFO
{
    TRANSPORT_TYPE Type;
}

struct USE_OPTION_TRANSPORT_PARAMETERS
{
    uint   Tag;
    ushort Length;
    ushort Reserved;
}

struct WKSTA_INFO_100
{
    uint          wki100_platform_id;
    const(wchar)* wki100_computername;
    const(wchar)* wki100_langroup;
    uint          wki100_ver_major;
    uint          wki100_ver_minor;
}

struct WKSTA_INFO_101
{
    uint          wki101_platform_id;
    const(wchar)* wki101_computername;
    const(wchar)* wki101_langroup;
    uint          wki101_ver_major;
    uint          wki101_ver_minor;
    const(wchar)* wki101_lanroot;
}

struct WKSTA_INFO_102
{
    uint          wki102_platform_id;
    const(wchar)* wki102_computername;
    const(wchar)* wki102_langroup;
    uint          wki102_ver_major;
    uint          wki102_ver_minor;
    const(wchar)* wki102_lanroot;
    uint          wki102_logged_on_users;
}

struct WKSTA_INFO_302
{
    uint          wki302_char_wait;
    uint          wki302_collection_time;
    uint          wki302_maximum_collection_count;
    uint          wki302_keep_conn;
    uint          wki302_keep_search;
    uint          wki302_max_cmds;
    uint          wki302_num_work_buf;
    uint          wki302_siz_work_buf;
    uint          wki302_max_wrk_cache;
    uint          wki302_sess_timeout;
    uint          wki302_siz_error;
    uint          wki302_num_alerts;
    uint          wki302_num_services;
    uint          wki302_errlog_sz;
    uint          wki302_print_buf_time;
    uint          wki302_num_char_buf;
    uint          wki302_siz_char_buf;
    const(wchar)* wki302_wrk_heuristics;
    uint          wki302_mailslots;
    uint          wki302_num_dgram_buf;
}

struct WKSTA_INFO_402
{
    uint          wki402_char_wait;
    uint          wki402_collection_time;
    uint          wki402_maximum_collection_count;
    uint          wki402_keep_conn;
    uint          wki402_keep_search;
    uint          wki402_max_cmds;
    uint          wki402_num_work_buf;
    uint          wki402_siz_work_buf;
    uint          wki402_max_wrk_cache;
    uint          wki402_sess_timeout;
    uint          wki402_siz_error;
    uint          wki402_num_alerts;
    uint          wki402_num_services;
    uint          wki402_errlog_sz;
    uint          wki402_print_buf_time;
    uint          wki402_num_char_buf;
    uint          wki402_siz_char_buf;
    const(wchar)* wki402_wrk_heuristics;
    uint          wki402_mailslots;
    uint          wki402_num_dgram_buf;
    uint          wki402_max_threads;
}

struct WKSTA_INFO_502
{
    uint wki502_char_wait;
    uint wki502_collection_time;
    uint wki502_maximum_collection_count;
    uint wki502_keep_conn;
    uint wki502_max_cmds;
    uint wki502_sess_timeout;
    uint wki502_siz_char_buf;
    uint wki502_max_threads;
    uint wki502_lock_quota;
    uint wki502_lock_increment;
    uint wki502_lock_maximum;
    uint wki502_pipe_increment;
    uint wki502_pipe_maximum;
    uint wki502_cache_file_timeout;
    uint wki502_dormant_file_limit;
    uint wki502_read_ahead_throughput;
    uint wki502_num_mailslot_buffers;
    uint wki502_num_srv_announce_buffers;
    uint wki502_max_illegal_datagram_events;
    uint wki502_illegal_datagram_event_reset_frequency;
    BOOL wki502_log_election_packets;
    BOOL wki502_use_opportunistic_locking;
    BOOL wki502_use_unlock_behind;
    BOOL wki502_use_close_behind;
    BOOL wki502_buf_named_pipes;
    BOOL wki502_use_lock_read_unlock;
    BOOL wki502_utilize_nt_caching;
    BOOL wki502_use_raw_read;
    BOOL wki502_use_raw_write;
    BOOL wki502_use_write_raw_data;
    BOOL wki502_use_encryption;
    BOOL wki502_buf_files_deny_write;
    BOOL wki502_buf_read_only_files;
    BOOL wki502_force_core_create_mode;
    BOOL wki502_use_512_byte_max_transfer;
}

struct WKSTA_INFO_1010
{
    uint wki1010_char_wait;
}

struct WKSTA_INFO_1011
{
    uint wki1011_collection_time;
}

struct WKSTA_INFO_1012
{
    uint wki1012_maximum_collection_count;
}

struct WKSTA_INFO_1027
{
    uint wki1027_errlog_sz;
}

struct WKSTA_INFO_1028
{
    uint wki1028_print_buf_time;
}

struct WKSTA_INFO_1032
{
    uint wki1032_wrk_heuristics;
}

struct WKSTA_INFO_1013
{
    uint wki1013_keep_conn;
}

struct WKSTA_INFO_1018
{
    uint wki1018_sess_timeout;
}

struct WKSTA_INFO_1023
{
    uint wki1023_siz_char_buf;
}

struct WKSTA_INFO_1033
{
    uint wki1033_max_threads;
}

struct WKSTA_INFO_1041
{
    uint wki1041_lock_quota;
}

struct WKSTA_INFO_1042
{
    uint wki1042_lock_increment;
}

struct WKSTA_INFO_1043
{
    uint wki1043_lock_maximum;
}

struct WKSTA_INFO_1044
{
    uint wki1044_pipe_increment;
}

struct WKSTA_INFO_1045
{
    uint wki1045_pipe_maximum;
}

struct WKSTA_INFO_1046
{
    uint wki1046_dormant_file_limit;
}

struct WKSTA_INFO_1047
{
    uint wki1047_cache_file_timeout;
}

struct WKSTA_INFO_1048
{
    BOOL wki1048_use_opportunistic_locking;
}

struct WKSTA_INFO_1049
{
    BOOL wki1049_use_unlock_behind;
}

struct WKSTA_INFO_1050
{
    BOOL wki1050_use_close_behind;
}

struct WKSTA_INFO_1051
{
    BOOL wki1051_buf_named_pipes;
}

struct WKSTA_INFO_1052
{
    BOOL wki1052_use_lock_read_unlock;
}

struct WKSTA_INFO_1053
{
    BOOL wki1053_utilize_nt_caching;
}

struct WKSTA_INFO_1054
{
    BOOL wki1054_use_raw_read;
}

struct WKSTA_INFO_1055
{
    BOOL wki1055_use_raw_write;
}

struct WKSTA_INFO_1056
{
    BOOL wki1056_use_write_raw_data;
}

struct WKSTA_INFO_1057
{
    BOOL wki1057_use_encryption;
}

struct WKSTA_INFO_1058
{
    BOOL wki1058_buf_files_deny_write;
}

struct WKSTA_INFO_1059
{
    BOOL wki1059_buf_read_only_files;
}

struct WKSTA_INFO_1060
{
    BOOL wki1060_force_core_create_mode;
}

struct WKSTA_INFO_1061
{
    BOOL wki1061_use_512_byte_max_transfer;
}

struct WKSTA_INFO_1062
{
    uint wki1062_read_ahead_throughput;
}

struct WKSTA_USER_INFO_0
{
    const(wchar)* wkui0_username;
}

struct WKSTA_USER_INFO_1
{
    const(wchar)* wkui1_username;
    const(wchar)* wkui1_logon_domain;
    const(wchar)* wkui1_oth_domains;
    const(wchar)* wkui1_logon_server;
}

struct WKSTA_USER_INFO_1101
{
    const(wchar)* wkui1101_oth_domains;
}

struct WKSTA_TRANSPORT_INFO_0
{
    uint          wkti0_quality_of_service;
    uint          wkti0_number_of_vcs;
    const(wchar)* wkti0_transport_name;
    const(wchar)* wkti0_transport_address;
    BOOL          wkti0_wan_ish;
}

// Functions

@DllImport("samcli")
uint NetUserAdd(const(wchar)* servername, uint level, char* buf, uint* parm_err);

@DllImport("samcli")
uint NetUserEnum(const(wchar)* servername, uint level, uint filter, ubyte** bufptr, uint prefmaxlen, 
                 uint* entriesread, uint* totalentries, uint* resume_handle);

@DllImport("samcli")
uint NetUserGetInfo(const(wchar)* servername, const(wchar)* username, uint level, ubyte** bufptr);

@DllImport("samcli")
uint NetUserSetInfo(const(wchar)* servername, const(wchar)* username, uint level, char* buf, uint* parm_err);

@DllImport("samcli")
uint NetUserDel(const(wchar)* servername, const(wchar)* username);

@DllImport("samcli")
uint NetUserGetGroups(const(wchar)* servername, const(wchar)* username, uint level, ubyte** bufptr, 
                      uint prefmaxlen, uint* entriesread, uint* totalentries);

@DllImport("samcli")
uint NetUserSetGroups(const(wchar)* servername, const(wchar)* username, uint level, char* buf, uint num_entries);

@DllImport("samcli")
uint NetUserGetLocalGroups(const(wchar)* servername, const(wchar)* username, uint level, uint flags, 
                           ubyte** bufptr, uint prefmaxlen, uint* entriesread, uint* totalentries);

@DllImport("samcli")
uint NetUserModalsGet(const(wchar)* servername, uint level, ubyte** bufptr);

@DllImport("samcli")
uint NetUserModalsSet(const(wchar)* servername, uint level, char* buf, uint* parm_err);

@DllImport("samcli")
uint NetUserChangePassword(const(wchar)* domainname, const(wchar)* username, const(wchar)* oldpassword, 
                           const(wchar)* newpassword);

@DllImport("samcli")
uint NetGroupAdd(const(wchar)* servername, uint level, char* buf, uint* parm_err);

@DllImport("samcli")
uint NetGroupAddUser(const(wchar)* servername, const(wchar)* GroupName, const(wchar)* username);

@DllImport("samcli")
uint NetGroupEnum(const(wchar)* servername, uint level, ubyte** bufptr, uint prefmaxlen, uint* entriesread, 
                  uint* totalentries, size_t* resume_handle);

@DllImport("samcli")
uint NetGroupGetInfo(const(wchar)* servername, const(wchar)* groupname, uint level, ubyte** bufptr);

@DllImport("samcli")
uint NetGroupSetInfo(const(wchar)* servername, const(wchar)* groupname, uint level, char* buf, uint* parm_err);

@DllImport("samcli")
uint NetGroupDel(const(wchar)* servername, const(wchar)* groupname);

@DllImport("samcli")
uint NetGroupDelUser(const(wchar)* servername, const(wchar)* GroupName, const(wchar)* Username);

@DllImport("samcli")
uint NetGroupGetUsers(const(wchar)* servername, const(wchar)* groupname, uint level, ubyte** bufptr, 
                      uint prefmaxlen, uint* entriesread, uint* totalentries, size_t* ResumeHandle);

@DllImport("samcli")
uint NetGroupSetUsers(const(wchar)* servername, const(wchar)* groupname, uint level, char* buf, uint totalentries);

@DllImport("samcli")
uint NetLocalGroupAdd(const(wchar)* servername, uint level, char* buf, uint* parm_err);

@DllImport("samcli")
uint NetLocalGroupAddMember(const(wchar)* servername, const(wchar)* groupname, void* membersid);

@DllImport("samcli")
uint NetLocalGroupEnum(const(wchar)* servername, uint level, ubyte** bufptr, uint prefmaxlen, uint* entriesread, 
                       uint* totalentries, size_t* resumehandle);

@DllImport("samcli")
uint NetLocalGroupGetInfo(const(wchar)* servername, const(wchar)* groupname, uint level, ubyte** bufptr);

@DllImport("samcli")
uint NetLocalGroupSetInfo(const(wchar)* servername, const(wchar)* groupname, uint level, char* buf, uint* parm_err);

@DllImport("samcli")
uint NetLocalGroupDel(const(wchar)* servername, const(wchar)* groupname);

@DllImport("samcli")
uint NetLocalGroupDelMember(const(wchar)* servername, const(wchar)* groupname, void* membersid);

@DllImport("samcli")
uint NetLocalGroupGetMembers(const(wchar)* servername, const(wchar)* localgroupname, uint level, ubyte** bufptr, 
                             uint prefmaxlen, uint* entriesread, uint* totalentries, size_t* resumehandle);

@DllImport("samcli")
uint NetLocalGroupSetMembers(const(wchar)* servername, const(wchar)* groupname, uint level, char* buf, 
                             uint totalentries);

@DllImport("samcli")
uint NetLocalGroupAddMembers(const(wchar)* servername, const(wchar)* groupname, uint level, char* buf, 
                             uint totalentries);

@DllImport("samcli")
uint NetLocalGroupDelMembers(const(wchar)* servername, const(wchar)* groupname, uint level, char* buf, 
                             uint totalentries);

@DllImport("samcli")
uint NetQueryDisplayInformation(const(wchar)* ServerName, uint Level, uint Index, uint EntriesRequested, 
                                uint PreferredMaximumLength, uint* ReturnedEntryCount, void** SortedBuffer);

@DllImport("samcli")
uint NetGetDisplayInformationIndex(const(wchar)* ServerName, uint Level, const(wchar)* Prefix, uint* Index);

@DllImport("NETAPI32")
uint NetAccessAdd(const(wchar)* servername, uint level, char* buf, uint* parm_err);

@DllImport("NETAPI32")
uint NetAccessEnum(const(wchar)* servername, const(wchar)* BasePath, uint Recursive, uint level, ubyte** bufptr, 
                   uint prefmaxlen, uint* entriesread, uint* totalentries, uint* resume_handle);

@DllImport("NETAPI32")
uint NetAccessGetInfo(const(wchar)* servername, const(wchar)* resource, uint level, ubyte** bufptr);

@DllImport("NETAPI32")
uint NetAccessSetInfo(const(wchar)* servername, const(wchar)* resource, uint level, char* buf, uint* parm_err);

@DllImport("NETAPI32")
uint NetAccessDel(const(wchar)* servername, const(wchar)* resource);

@DllImport("NETAPI32")
uint NetAccessGetUserPerms(const(wchar)* servername, const(wchar)* UGname, const(wchar)* resource, uint* Perms);

@DllImport("samcli")
uint NetValidatePasswordPolicy(const(wchar)* ServerName, void* Qualifier, 
                               NET_VALIDATE_PASSWORD_TYPE ValidationType, void* InputArg, void** OutputArg);

@DllImport("samcli")
uint NetValidatePasswordPolicyFree(void** OutputArg);

@DllImport("logoncli")
uint NetGetDCName(const(wchar)* ServerName, const(wchar)* DomainName, ubyte** Buffer);

@DllImport("logoncli")
uint NetGetAnyDCName(const(wchar)* ServerName, const(wchar)* DomainName, ubyte** Buffer);

@DllImport("wkscli")
uint NetJoinDomain(const(wchar)* lpServer, const(wchar)* lpDomain, const(wchar)* lpMachineAccountOU, 
                   const(wchar)* lpAccount, const(wchar)* lpPassword, uint fJoinOptions);

@DllImport("wkscli")
uint NetUnjoinDomain(const(wchar)* lpServer, const(wchar)* lpAccount, const(wchar)* lpPassword, 
                     uint fUnjoinOptions);

@DllImport("wkscli")
uint NetRenameMachineInDomain(const(wchar)* lpServer, const(wchar)* lpNewMachineName, const(wchar)* lpAccount, 
                              const(wchar)* lpPassword, uint fRenameOptions);

@DllImport("wkscli")
uint NetValidateName(const(wchar)* lpServer, const(wchar)* lpName, const(wchar)* lpAccount, 
                     const(wchar)* lpPassword, NETSETUP_NAME_TYPE NameType);

@DllImport("wkscli")
uint NetGetJoinableOUs(const(wchar)* lpServer, const(wchar)* lpDomain, const(wchar)* lpAccount, 
                       const(wchar)* lpPassword, uint* OUCount, ushort*** OUs);

@DllImport("wkscli")
uint NetAddAlternateComputerName(const(wchar)* Server, const(wchar)* AlternateName, const(wchar)* DomainAccount, 
                                 const(wchar)* DomainAccountPassword, uint Reserved);

@DllImport("wkscli")
uint NetRemoveAlternateComputerName(const(wchar)* Server, const(wchar)* AlternateName, const(wchar)* DomainAccount, 
                                    const(wchar)* DomainAccountPassword, uint Reserved);

@DllImport("wkscli")
uint NetSetPrimaryComputerName(const(wchar)* Server, const(wchar)* PrimaryName, const(wchar)* DomainAccount, 
                               const(wchar)* DomainAccountPassword, uint Reserved);

@DllImport("wkscli")
uint NetEnumerateComputerNames(const(wchar)* Server, NET_COMPUTER_NAME_TYPE NameType, uint Reserved, 
                               uint* EntryCount, ushort*** ComputerNames);

@DllImport("NETAPI32")
uint NetProvisionComputerAccount(const(wchar)* lpDomain, const(wchar)* lpMachineName, 
                                 const(wchar)* lpMachineAccountOU, const(wchar)* lpDcName, uint dwOptions, 
                                 ubyte** pProvisionBinData, uint* pdwProvisionBinDataSize, 
                                 ushort** pProvisionTextData);

@DllImport("NETAPI32")
uint NetRequestOfflineDomainJoin(char* pProvisionBinData, uint cbProvisionBinDataSize, uint dwOptions, 
                                 const(wchar)* lpWindowsPath);

@DllImport("NETAPI32")
uint NetCreateProvisioningPackage(NETSETUP_PROVISIONING_PARAMS* pProvisioningParams, ubyte** ppPackageBinData, 
                                  uint* pdwPackageBinDataSize, ushort** ppPackageTextData);

@DllImport("NETAPI32")
uint NetRequestProvisioningPackageInstall(char* pPackageBinData, uint dwPackageBinDataSize, 
                                          uint dwProvisionOptions, const(wchar)* lpWindowsPath, void* pvReserved);

@DllImport("NETAPI32")
HRESULT NetGetAadJoinInformation(const(wchar)* pcszTenantId, DSREG_JOIN_INFO** ppJoinInfo);

@DllImport("NETAPI32")
void NetFreeAadJoinInformation(DSREG_JOIN_INFO* pJoinInfo);

@DllImport("wkscli")
uint NetGetJoinInformation(const(wchar)* lpServer, ushort** lpNameBuffer, NETSETUP_JOIN_STATUS* BufferType);

@DllImport("mstask")
HRESULT GetNetScheduleAccountInformation(const(wchar)* pwszServerName, uint ccAccount, char* wszAccount);

@DllImport("mstask")
HRESULT SetNetScheduleAccountInformation(const(wchar)* pwszServerName, const(wchar)* pwszAccount, 
                                         const(wchar)* pwszPassword);

@DllImport("NETAPI32")
uint NetAlertRaise(const(wchar)* AlertType, void* Buffer, uint BufferSize);

@DllImport("NETAPI32")
uint NetAlertRaiseEx(const(wchar)* AlertType, void* VariableInfo, uint VariableInfoSize, const(wchar)* ServiceName);

@DllImport("netutils")
uint NetApiBufferAllocate(uint ByteCount, void** Buffer);

@DllImport("netutils")
uint NetApiBufferFree(void* Buffer);

@DllImport("netutils")
uint NetApiBufferReallocate(void* OldBuffer, uint NewByteCount, void** NewBuffer);

@DllImport("netutils")
uint NetApiBufferSize(void* Buffer, uint* ByteCount);

@DllImport("NETAPI32")
uint NetAuditClear(const(wchar)* server, const(wchar)* backupfile, const(wchar)* service);

@DllImport("NETAPI32")
uint NetAuditRead(const(wchar)* server, const(wchar)* service, HLOG* auditloghandle, uint offset, uint* reserved1, 
                  uint reserved2, uint offsetflag, ubyte** bufptr, uint prefmaxlen, uint* bytesread, 
                  uint* totalavailable);

@DllImport("NETAPI32")
uint NetAuditWrite(uint type, ubyte* buf, uint numbytes, const(wchar)* service, ubyte* reserved);

@DllImport("NETAPI32")
uint NetConfigGet(const(wchar)* server, const(wchar)* component, const(wchar)* parameter, ubyte** bufptr);

@DllImport("NETAPI32")
uint NetConfigGetAll(const(wchar)* server, const(wchar)* component, ubyte** bufptr);

@DllImport("NETAPI32")
uint NetConfigSet(const(wchar)* server, const(wchar)* reserved1, const(wchar)* component, uint level, 
                  uint reserved2, ubyte* buf, uint reserved3);

@DllImport("NETAPI32")
uint NetErrorLogClear(const(wchar)* UncServerName, const(wchar)* BackupFile, ubyte* Reserved);

@DllImport("NETAPI32")
uint NetErrorLogRead(const(wchar)* UncServerName, const(wchar)* Reserved1, HLOG* ErrorLogHandle, uint Offset, 
                     uint* Reserved2, uint Reserved3, uint OffsetFlag, ubyte** BufPtr, uint PrefMaxSize, 
                     uint* BytesRead, uint* TotalAvailable);

@DllImport("NETAPI32")
uint NetErrorLogWrite(ubyte* Reserved1, uint Code, const(wchar)* Component, ubyte* Buffer, uint NumBytes, 
                      ubyte* MsgBuf, uint StrCount, ubyte* Reserved2);

@DllImport("NETAPI32")
uint NetMessageNameAdd(const(wchar)* servername, const(wchar)* msgname);

@DllImport("NETAPI32")
uint NetMessageNameEnum(const(wchar)* servername, uint level, ubyte** bufptr, uint prefmaxlen, uint* entriesread, 
                        uint* totalentries, uint* resume_handle);

@DllImport("NETAPI32")
uint NetMessageNameGetInfo(const(wchar)* servername, const(wchar)* msgname, uint level, ubyte** bufptr);

@DllImport("NETAPI32")
uint NetMessageNameDel(const(wchar)* servername, const(wchar)* msgname);

@DllImport("NETAPI32")
uint NetMessageBufferSend(const(wchar)* servername, const(wchar)* msgname, const(wchar)* fromname, ubyte* buf, 
                          uint buflen);

@DllImport("srvcli")
uint NetRemoteTOD(const(wchar)* UncServerName, ubyte** BufferPtr);

@DllImport("netutils")
uint NetRemoteComputerSupports(const(wchar)* UncServerName, uint OptionsWanted, uint* OptionsSupported);

@DllImport("schedcli")
uint NetScheduleJobAdd(const(wchar)* Servername, ubyte* Buffer, uint* JobId);

@DllImport("schedcli")
uint NetScheduleJobDel(const(wchar)* Servername, uint MinJobId, uint MaxJobId);

@DllImport("schedcli")
uint NetScheduleJobEnum(const(wchar)* Servername, ubyte** PointerToBuffer, uint PrefferedMaximumLength, 
                        uint* EntriesRead, uint* TotalEntries, uint* ResumeHandle);

@DllImport("schedcli")
uint NetScheduleJobGetInfo(const(wchar)* Servername, uint JobId, ubyte** PointerToBuffer);

@DllImport("NETAPI32")
uint NetServerEnum(const(wchar)* servername, uint level, ubyte** bufptr, uint prefmaxlen, uint* entriesread, 
                   uint* totalentries, uint servertype, const(wchar)* domain, uint* resume_handle);

@DllImport("srvcli")
uint NetServerGetInfo(const(wchar)* servername, uint level, ubyte** bufptr);

@DllImport("srvcli")
uint NetServerSetInfo(const(wchar)* servername, uint level, char* buf, uint* ParmError);

@DllImport("srvcli")
uint NetServerDiskEnum(const(wchar)* servername, uint level, ubyte** bufptr, uint prefmaxlen, uint* entriesread, 
                       uint* totalentries, uint* resume_handle);

@DllImport("srvcli")
uint NetServerComputerNameAdd(const(wchar)* ServerName, const(wchar)* EmulatedDomainName, 
                              const(wchar)* EmulatedServerName);

@DllImport("srvcli")
uint NetServerComputerNameDel(const(wchar)* ServerName, const(wchar)* EmulatedServerName);

@DllImport("srvcli")
uint NetServerTransportAdd(const(wchar)* servername, uint level, char* bufptr);

@DllImport("srvcli")
uint NetServerTransportAddEx(const(wchar)* servername, uint level, char* bufptr);

@DllImport("srvcli")
uint NetServerTransportDel(const(wchar)* servername, uint level, char* bufptr);

@DllImport("srvcli")
uint NetServerTransportEnum(const(wchar)* servername, uint level, ubyte** bufptr, uint prefmaxlen, 
                            uint* entriesread, uint* totalentries, uint* resume_handle);

@DllImport("NETAPI32")
uint NetServiceControl(const(wchar)* servername, const(wchar)* service, uint opcode, uint arg, ubyte** bufptr);

@DllImport("NETAPI32")
uint NetServiceEnum(const(wchar)* servername, uint level, ubyte** bufptr, uint prefmaxlen, uint* entriesread, 
                    uint* totalentries, uint* resume_handle);

@DllImport("NETAPI32")
uint NetServiceGetInfo(const(wchar)* servername, const(wchar)* service, uint level, ubyte** bufptr);

@DllImport("NETAPI32")
uint NetServiceInstall(const(wchar)* servername, const(wchar)* service, uint argc, char* argv, ubyte** bufptr);

@DllImport("wkscli")
uint NetUseAdd(byte* servername, uint LevelFlags, char* buf, uint* parm_err);

@DllImport("wkscli")
uint NetUseDel(const(wchar)* UncServerName, const(wchar)* UseName, uint ForceLevelFlags);

@DllImport("wkscli")
uint NetUseEnum(const(wchar)* UncServerName, uint LevelFlags, ubyte** BufPtr, uint PreferedMaximumSize, 
                uint* EntriesRead, uint* TotalEntries, uint* ResumeHandle);

@DllImport("wkscli")
uint NetUseGetInfo(const(wchar)* UncServerName, const(wchar)* UseName, uint LevelFlags, ubyte** bufptr);

@DllImport("wkscli")
uint NetWkstaGetInfo(const(wchar)* servername, uint level, ubyte** bufptr);

@DllImport("wkscli")
uint NetWkstaSetInfo(const(wchar)* servername, uint level, char* buffer, uint* parm_err);

@DllImport("wkscli")
uint NetWkstaUserGetInfo(const(wchar)* reserved, uint level, ubyte** bufptr);

@DllImport("wkscli")
uint NetWkstaUserSetInfo(const(wchar)* reserved, uint level, char* buf, uint* parm_err);

@DllImport("wkscli")
uint NetWkstaUserEnum(const(wchar)* servername, uint level, ubyte** bufptr, uint prefmaxlen, uint* entriesread, 
                      uint* totalentries, uint* resumehandle);

@DllImport("wkscli")
uint NetWkstaTransportAdd(byte* servername, uint level, char* buf, uint* parm_err);

@DllImport("wkscli")
uint NetWkstaTransportDel(const(wchar)* servername, const(wchar)* transportname, uint ucond);

@DllImport("wkscli")
uint NetWkstaTransportEnum(byte* servername, uint level, ubyte** bufptr, uint prefmaxlen, uint* entriesread, 
                           uint* totalentries, uint* resume_handle);


