// Written in the D programming language.

module windows.wmi;

public import windows.core;
public import windows.automation : BSTR, IDispatch, SAFEARRAY, VARIANT;
public import windows.com : HRESULT, IUnknown;
public import windows.systemservices : BOOL, PWSTR;

extern(Windows) @nogc nothrow:


// Enums


///Contains flags used to describe a path.
alias tag_WBEM_PATH_STATUS_FLAG = int;
enum : int
{
    ///Path has "." or <b>NULL</b> as the server name.
    WBEMPATH_INFO_ANON_LOCAL_MACHINE    = 0x00000001,
    ///Server name is specified in the path and that name is not ".".
    WBEMPATH_INFO_HAS_MACHINE_NAME      = 0x00000002,
    ///There is a class part to the path, but it is not an instance.
    WBEMPATH_INFO_IS_CLASS_REF          = 0x00000004,
    ///There is a class part to the path and there are key values.
    WBEMPATH_INFO_IS_INST_REF           = 0x00000008,
    ///A subscope is present in the path. Currently WMI does not support scopes.
    WBEMPATH_INFO_HAS_SUBSCOPES         = 0x00000010,
    ///Compound key is used.
    WBEMPATH_INFO_IS_COMPOUND           = 0x00000020,
    ///One or more keys has a CIM reference.
    WBEMPATH_INFO_HAS_V2_REF_PATHS      = 0x00000040,
    ///Key names are missing somewhere in the path.
    WBEMPATH_INFO_HAS_IMPLIED_KEY       = 0x00000080,
    ///One or more singletons.
    WBEMPATH_INFO_CONTAINS_SINGLETON    = 0x00000100,
    ///No scopes and no CIM_REFERENCE keys.
    WBEMPATH_INFO_V1_COMPLIANT          = 0x00000200,
    ///Reserved. Do not use.
    WBEMPATH_INFO_V2_COMPLIANT          = 0x00000400,
    ///Reserved. Do not use.
    WBEMPATH_INFO_CIM_COMPLIANT         = 0x00000800,
    ///Object is a singleton.
    WBEMPATH_INFO_IS_SINGLETON          = 0x00001000,
    ///Path is just "..".
    WBEMPATH_INFO_IS_PARENT             = 0x00002000,
    ///There is no class portion of the path.
    WBEMPATH_INFO_SERVER_NAMESPACE_ONLY = 0x00004000,
    ///Path parser was initialized using SetText.
    WBEMPATH_INFO_NATIVE_PATH           = 0x00008000,
    ///Reserved. Do not use.
    WBEMPATH_INFO_WMI_PATH              = 0x00010000,
    WBEMPATH_INFO_PATH_HAD_SERVER       = 0x00020000,
}

///Contains flags specifying the type of paths accepted.
alias tag_WBEM_PATH_CREATE_FLAG = int;
enum : int
{
    ///Allow paths without server names.
    WBEMPATH_CREATE_ACCEPT_RELATIVE   = 0x00000001,
    ///Reserved for future use.
    WBEMPATH_CREATE_ACCEPT_ABSOLUTE   = 0x00000002,
    ///Allow setting an empty path (which additionally clears out the object), Also allows paths which have just the
    ///server names, or paths which don't have server names.
    WBEMPATH_CREATE_ACCEPT_ALL        = 0x00000004,
    WBEMPATH_TREAT_SINGLE_IDENT_AS_NS = 0x00000008,
}

///Contains flags which controls how the text is returned.
alias tag_WBEM_GET_TEXT_FLAGS = int;
enum : int
{
    ///Obsolete. Do not use.
    WBEMPATH_COMPRESSED                    = 0x00000001,
    ///Returns the relative path, skips server and namespaces.
    WBEMPATH_GET_RELATIVE_ONLY             = 0x00000002,
    ///Returns the entire path, including server and namespace.
    WBEMPATH_GET_SERVER_TOO                = 0x00000004,
    ///Returns only the server and namespace portion of the path. Ignores the class or key portion.
    WBEMPATH_GET_SERVER_AND_NAMESPACE_ONLY = 0x00000008,
    ///Returns only the namespace portion of the path.
    WBEMPATH_GET_NAMESPACE_ONLY            = 0x00000010,
    WBEMPATH_GET_ORIGINAL                  = 0x00000020,
}

///Contains flags which control the format of the text.
alias tag_WBEM_GET_KEY_FLAGS = int;
enum : int
{
    ///Not used.
    WBEMPATH_TEXT       = 0x00000001,
    WBEMPATH_QUOTEDTEXT = 0x00000002,
}

///Contains constants used to specify the type of analysis to perform by using the GetAnalysis method.
alias WMIQ_ANALYSIS_TYPE = int;
enum : int
{
    ///Used if the query has a SELECT clause. When this type of analysis is used, <i>pAnalysis</i> points to an
    ///SWbemRpnEncodedQuery structure.
    WMIQ_ANALYSIS_RPN_SEQUENCE         = 0x00000001,
    ///Used to return information about association type queries. When this type of analysis is used, <i>pAnalysis</i>
    ///points to an SWbemAssocQueryInf structure.
    WMIQ_ANALYSIS_ASSOC_QUERY          = 0x00000002,
    ///Unused. Reserved for future use.
    WMIQ_ANALYSIS_PROP_ANALYSIS_MATRIX = 0x00000003,
    ///Used to return a text string that has the original query text. If this type of analysis is used, <i>pAnalysis</i>
    ///points to a text string that contains the original query text. You can use this parameter if a parser object is
    ///passed to another method.
    WMIQ_ANALYSIS_QUERY_TEXT           = 0x00000004,
    WMIQ_ANALYSIS_RESERVED             = 0x08000000,
}

///Contains flags that describe query tokens used in the GetAnalysis method.
alias WMIQ_RPN_TOKEN_FLAGS = int;
enum : int
{
    ///This token is an expression, for example, J = 7.
    WMIQ_RPN_TOKEN_EXPRESSION    = 0x00000001,
    ///This token is a logical AND.
    WMIQ_RPN_TOKEN_AND           = 0x00000002,
    ///This token is a logical OR.
    WMIQ_RPN_TOKEN_OR            = 0x00000003,
    ///This token is a logical NOT.
    WMIQ_RPN_TOKEN_NOT           = 0x00000004,
    ///The operator is undefined or unknown.
    WMIQ_RPN_OP_UNDEFINED        = 0x00000000,
    ///The operator is equal-to (=).
    WMIQ_RPN_OP_EQ               = 0x00000001,
    ///The operator is not-equal-to (&lt;&gt;).
    WMIQ_RPN_OP_NE               = 0x00000002,
    ///The operator is greater-than-or-equal-to (&gt;=).
    WMIQ_RPN_OP_GE               = 0x00000003,
    ///The operator is less-than-or-equal-to (&lt;=).
    WMIQ_RPN_OP_LE               = 0x00000004,
    ///The operator is less-than (&lt;) .
    WMIQ_RPN_OP_LT               = 0x00000005,
    ///The operator is greater-than (&gt;).
    WMIQ_RPN_OP_GT               = 0x00000006,
    ///The operator is LIKE.
    WMIQ_RPN_OP_LIKE             = 0x00000007,
    ///The operator is ISA.
    WMIQ_RPN_OP_ISA              = 0x00000008,
    ///The operator is ISNOTA.
    WMIQ_RPN_OP_ISNOTA           = 0x00000009,
    ///The operator is ISNULL.
    WMIQ_RPN_OP_ISNULL           = 0x0000000a,
    ///The operator is ISNOTNULL.
    WMIQ_RPN_OP_ISNOTNULL        = 0x0000000b,
    ///Left argument is a property name.
    WMIQ_RPN_LEFT_PROPERTY_NAME  = 0x00000001,
    ///Right argument is a property name.
    WMIQ_RPN_RIGHT_PROPERTY_NAME = 0x00000002,
    ///Has a second constant. Used with "BETWEEN" clauses.
    WMIQ_RPN_CONST2              = 0x00000004,
    ///Has a constant.
    WMIQ_RPN_CONST               = 0x00000008,
    ///The field <b>m_uOperator</b> is not 0 (zero).
    WMIQ_RPN_RELOP               = 0x00000010,
    ///Left argument is a function.
    WMIQ_RPN_LEFT_FUNCTION       = 0x00000020,
    ///Right argument is a function.
    WMIQ_RPN_RIGHT_FUNCTION      = 0x00000040,
    ///Reserved for future use.
    WMIQ_RPN_GET_TOKEN_TYPE      = 0x00000001,
    ///Reserved for future use.
    WMIQ_RPN_GET_EXPR_SHAPE      = 0x00000002,
    ///Reserved for future use.
    WMIQ_RPN_GET_LEFT_FUNCTION   = 0x00000003,
    ///Reserved for future use.
    WMIQ_RPN_GET_RIGHT_FUNCTION  = 0x00000004,
    ///Reserved for future use.
    WMIQ_RPN_GET_RELOP           = 0x00000005,
    ///Reserved for future use.
    WMIQ_RPN_NEXT_TOKEN          = 0x00000001,
    ///FROM clause contains a single class.
    WMIQ_RPN_FROM_UNARY          = 0x00000001,
    ///FROM clause contains an object path.
    WMIQ_RPN_FROM_PATH           = 0x00000002,
    ///FROM clause contains a list of classes.
    WMIQ_RPN_FROM_CLASS_LIST     = 0x00000004,
    WMIQ_RPN_FROM_MULTIPLE       = 0x00000008,
}

///Contains flags that indicate the features in a query.
alias WMIQ_ASSOCQ_FLAGS = int;
enum : int
{
    ///Associators exist in the query.
    WMIQ_ASSOCQ_ASSOCIATORS            = 0x00000001,
    ///References exist in the query.
    WMIQ_ASSOCQ_REFERENCES             = 0x00000002,
    ///A result class is specified in the query.
    WMIQ_ASSOCQ_RESULTCLASS            = 0x00000004,
    ///An association class is specified in the query.
    WMIQ_ASSOCQ_ASSOCCLASS             = 0x00000008,
    ///A role is specified in the query.
    WMIQ_ASSOCQ_ROLE                   = 0x00000010,
    ///A result role is specified in the query.
    WMIQ_ASSOCQ_RESULTROLE             = 0x00000020,
    ///Required qualifiers are specified in the query.
    WMIQ_ASSOCQ_REQUIREDQUALIFIER      = 0x00000040,
    ///Required association qualifiers are specified in the query.
    WMIQ_ASSOCQ_REQUIREDASSOCQUALIFIER = 0x00000080,
    ///The query specifies class definitions only.
    WMIQ_ASSOCQ_CLASSDEFSONLY          = 0x00000100,
    ///The query contains the <b>KEYSONLY</b> keyword.
    WMIQ_ASSOCQ_KEYSONLY               = 0x00000200,
    ///The query returns only the schema.
    WMIQ_ASSOCQ_SCHEMAONLY             = 0x00000400,
    WMIQ_ASSOCQ_CLASSREFSONLY          = 0x00000800,
}

alias tag_WMIQ_LANGUAGE_FEATURES = int;
enum : int
{
    WMIQ_LF1_BASIC_SELECT                = 0x00000001,
    WMIQ_LF2_CLASS_NAME_IN_QUERY         = 0x00000002,
    WMIQ_LF3_STRING_CASE_FUNCTIONS       = 0x00000003,
    WMIQ_LF4_PROP_TO_PROP_TESTS          = 0x00000004,
    WMIQ_LF5_COUNT_STAR                  = 0x00000005,
    WMIQ_LF6_ORDER_BY                    = 0x00000006,
    WMIQ_LF7_DISTINCT                    = 0x00000007,
    WMIQ_LF8_ISA                         = 0x00000008,
    WMIQ_LF9_THIS                        = 0x00000009,
    WMIQ_LF10_COMPEX_SUBEXPRESSIONS      = 0x0000000a,
    WMIQ_LF11_ALIASING                   = 0x0000000b,
    WMIQ_LF12_GROUP_BY_HAVING            = 0x0000000c,
    WMIQ_LF13_WMI_WITHIN                 = 0x0000000d,
    WMIQ_LF14_SQL_WRITE_OPERATIONS       = 0x0000000e,
    WMIQ_LF15_GO                         = 0x0000000f,
    WMIQ_LF16_SINGLE_LEVEL_TRANSACTIONS  = 0x00000010,
    WMIQ_LF17_QUALIFIED_NAMES            = 0x00000011,
    WMIQ_LF18_ASSOCIATONS                = 0x00000012,
    WMIQ_LF19_SYSTEM_PROPERTIES          = 0x00000013,
    WMIQ_LF20_EXTENDED_SYSTEM_PROPERTIES = 0x00000014,
    WMIQ_LF21_SQL89_JOINS                = 0x00000015,
    WMIQ_LF22_SQL92_JOINS                = 0x00000016,
    WMIQ_LF23_SUBSELECTS                 = 0x00000017,
    WMIQ_LF24_UMI_EXTENSIONS             = 0x00000018,
    WMIQ_LF25_DATEPART                   = 0x00000019,
    WMIQ_LF26_LIKE                       = 0x0000001a,
    WMIQ_LF27_CIM_TEMPORAL_CONSTRUCTS    = 0x0000001b,
    WMIQ_LF28_STANDARD_AGGREGATES        = 0x0000001c,
    WMIQ_LF29_MULTI_LEVEL_ORDER_BY       = 0x0000001d,
    WMIQ_LF30_WMI_PRAGMAS                = 0x0000001e,
    WMIQ_LF31_QUALIFIER_TESTS            = 0x0000001f,
    WMIQ_LF32_SP_EXECUTE                 = 0x00000020,
    WMIQ_LF33_ARRAY_ACCESS               = 0x00000021,
    WMIQ_LF34_UNION                      = 0x00000022,
    WMIQ_LF35_COMPLEX_SELECT_TARGET      = 0x00000023,
    WMIQ_LF36_REFERENCE_TESTS            = 0x00000024,
    WMIQ_LF37_SELECT_INTO                = 0x00000025,
    WMIQ_LF38_BASIC_DATETIME_TESTS       = 0x00000026,
    WMIQ_LF39_COUNT_COLUMN               = 0x00000027,
    WMIQ_LF40_BETWEEN                    = 0x00000028,
    WMIQ_LF_LAST                         = 0x00000028,
}

alias tag_WMIQ_RPNQ_FEATURE = int;
enum : int
{
    WMIQ_RPNF_WHERE_CLAUSE_PRESENT = 0x00000001,
    WMIQ_RPNF_QUERY_IS_CONJUNCTIVE = 0x00000002,
    WMIQ_RPNF_QUERY_IS_DISJUNCTIVE = 0x00000004,
    WMIQ_RPNF_PROJECTION           = 0x00000008,
    WMIQ_RPNF_FEATURE_SELECT_STAR  = 0x00000010,
    WMIQ_RPNF_EQUALITY_TESTS_ONLY  = 0x00000020,
    WMIQ_RPNF_COUNT_STAR           = 0x00000040,
    WMIQ_RPNF_QUALIFIED_NAMES_USED = 0x00000080,
    WMIQ_RPNF_SYSPROP_CLASS_USED   = 0x00000100,
    WMIQ_RPNF_PROP_TO_PROP_TESTS   = 0x00000200,
    WMIQ_RPNF_ORDER_BY             = 0x00000400,
    WMIQ_RPNF_ISA_USED             = 0x00000800,
    WMIQ_RPNF_GROUP_BY_HAVING      = 0x00001000,
    WMIQ_RPNF_ARRAY_ACCESS_USED    = 0x00002000,
}

///Contains constants used to distinguish between classes and instances.
alias WBEM_GENUS_TYPE = int;
enum : int
{
    WBEM_GENUS_CLASS    = 0x00000001,
    WBEM_GENUS_INSTANCE = 0x00000002,
}

///Contains method parameter flags.
alias WBEM_CHANGE_FLAG_TYPE = int;
enum : int
{
    ///The class is created if it does not exist, or overwritten if it exists already.
    WBEM_FLAG_CREATE_OR_UPDATE  = 0x00000000,
    ///The class is overwritten if it exists already, but will not be created if it does not exist.The class must exist
    ///for the call to be successful.
    WBEM_FLAG_UPDATE_ONLY       = 0x00000001,
    ///This flag is used for creation only. The call fails if the class already exists.
    WBEM_FLAG_CREATE_ONLY       = 0x00000002,
    ///This flag allows a class to be updated if there are no derived classes and there are no instances for that class.
    ///It also allows updates in all cases if the change is just to nonimportant qualifiers (for example, the
    ///<b>Description</b> qualifier). This is the default behavior for this call and is used for compatibility with
    ///previous versions of Windows Management. If the class has instances or changes are to important qualifiers, the
    ///update fails.
    WBEM_FLAG_UPDATE_COMPATIBLE = 0x00000000,
    ///This flag allows updates of classes even if there are child classes as long as the change does not cause any
    ///conflicts with child classes. An example of an update this flag would allow would be to add a new property to the
    ///base class that was not previously mentioned in any of the child classes. If the class has instances, the update
    ///fails.
    WBEM_FLAG_UPDATE_SAFE_MODE  = 0x00000020,
    ///This flag forces updates of classes when conflicting child classes exist. An example of an update this flag would
    ///force would be if a class qualifier were defined in a child class, and the base class tried to add the same
    ///qualifier which conflicted with the existing one. In force mode, this conflict would be resolved by deleting the
    ///conflicting qualifier in the child class.
    WBEM_FLAG_UPDATE_FORCE_MODE = 0x00000040,
    ///A mask value that can be used to simplify testing for the other flag values.
    WBEM_MASK_UPDATE_MODE       = 0x00000060,
    WBEM_FLAG_ADVISORY          = 0x00010000,
}

///Contains general-purpose method parameter flags.
alias WBEM_GENERIC_FLAG_TYPE = int;
enum : int
{
    WBEM_FLAG_RETURN_IMMEDIATELY     = 0x00000010,
    WBEM_FLAG_RETURN_WBEM_COMPLETE   = 0x00000000,
    WBEM_FLAG_BIDIRECTIONAL          = 0x00000000,
    WBEM_FLAG_FORWARD_ONLY           = 0x00000020,
    WBEM_FLAG_NO_ERROR_OBJECT        = 0x00000040,
    WBEM_FLAG_RETURN_ERROR_OBJECT    = 0x00000000,
    WBEM_FLAG_SEND_STATUS            = 0x00000080,
    WBEM_FLAG_DONT_SEND_STATUS       = 0x00000000,
    WBEM_FLAG_ENSURE_LOCATABLE       = 0x00000100,
    WBEM_FLAG_DIRECT_READ            = 0x00000200,
    WBEM_FLAG_SEND_ONLY_SELECTED     = 0x00000000,
    WBEM_RETURN_WHEN_COMPLETE        = 0x00000000,
    WBEM_RETURN_IMMEDIATELY          = 0x00000010,
    WBEM_MASK_RESERVED_FLAGS         = 0x0001f000,
    WBEM_FLAG_USE_AMENDED_QUALIFIERS = 0x00020000,
    WBEM_FLAG_STRONG_VALIDATION      = 0x00100000,
}

///Describes the status of an asynchronous operation.
alias WBEM_STATUS_TYPE = int;
enum : int
{
    ///The operation has completed.
    WBEM_STATUS_COMPLETE                       = 0x00000000,
    ///Used in activating post-filtering.
    WBEM_STATUS_REQUIREMENTS                   = 0x00000001,
    ///The operation is still in progress.
    WBEM_STATUS_PROGRESS                       = 0x00000002,
    ///Reserved for future use.
    WBEM_STATUS_LOGGING_INFORMATION            = 0x00000100,
    ///Reserved for future use.
    WBEM_STATUS_LOGGING_INFORMATION_PROVIDER   = 0x00000200,
    ///Reserved for future use.
    WBEM_STATUS_LOGGING_INFORMATION_HOST       = 0x00000400,
    ///Reserved for future use.
    WBEM_STATUS_LOGGING_INFORMATION_REPOSITORY = 0x00000800,
    ///Reserved for future use.
    WBEM_STATUS_LOGGING_INFORMATION_ESS        = 0x00001000,
}

///Contains values used to specify the timeout for the IEnumWbemClassObject::Next method.
alias WBEM_TIMEOUT_TYPE = int;
enum : int
{
    WBEM_NO_WAIT  = 0x00000000,
    WBEM_INFINITE = 0xffffffff,
}

///Contains flags used with the IWbemClassObject::GetNames method.
alias WBEM_CONDITION_FLAG_TYPE = int;
enum : int
{
    WBEM_FLAG_ALWAYS                    = 0x00000000,
    WBEM_FLAG_ONLY_IF_TRUE              = 0x00000001,
    WBEM_FLAG_ONLY_IF_FALSE             = 0x00000002,
    WBEM_FLAG_ONLY_IF_IDENTICAL         = 0x00000003,
    WBEM_MASK_PRIMARY_CONDITION         = 0x00000003,
    WBEM_FLAG_KEYS_ONLY                 = 0x00000004,
    WBEM_FLAG_REFS_ONLY                 = 0x00000008,
    WBEM_FLAG_LOCAL_ONLY                = 0x00000010,
    WBEM_FLAG_PROPAGATED_ONLY           = 0x00000020,
    WBEM_FLAG_SYSTEM_ONLY               = 0x00000030,
    WBEM_FLAG_NONSYSTEM_ONLY            = 0x00000040,
    WBEM_MASK_CONDITION_ORIGIN          = 0x00000070,
    WBEM_FLAG_CLASS_OVERRIDES_ONLY      = 0x00000100,
    WBEM_FLAG_CLASS_LOCAL_AND_OVERRIDES = 0x00000200,
    WBEM_MASK_CLASS_CONDITION           = 0x00000300,
}

///Lists qualifier flavors.
alias WBEM_FLAVOR_TYPE = int;
enum : int
{
    ///The qualifier is not propagated to instances or derived classes.
    WBEM_FLAVOR_DONT_PROPAGATE                  = 0x00000000,
    ///The qualifier is propagated to instances.
    WBEM_FLAVOR_FLAG_PROPAGATE_TO_INSTANCE      = 0x00000001,
    ///The qualifier is propagated to derived classes. This flavor is only appropriate for qualifiers defined for a
    ///class and cannot be attached to a qualifier describing a class instance.
    WBEM_FLAVOR_FLAG_PROPAGATE_TO_DERIVED_CLASS = 0x00000002,
    WBEM_FLAVOR_MASK_PROPAGATION                = 0x0000000f,
    ///When propagated to a derived class or instance, the value of the qualifier can be overridden. Setting
    ///EnableOverride is optional because being able to override the qualifier value is the default functionality for
    ///propagated qualifiers.
    WBEM_FLAVOR_OVERRIDABLE                     = 0x00000000,
    ///The qualifier cannot be overridden in a derived class or instance. Note that being able to override a propagated
    ///qualifier is the default.
    WBEM_FLAVOR_NOT_OVERRIDABLE                 = 0x00000010,
    WBEM_FLAVOR_MASK_PERMISSIONS                = 0x00000010,
    ///For a class: the property belongs to the derived-most class. For an instance: the property is modified at the
    ///instance level (that is, either a value was supplied or a qualifier was added/modified).
    WBEM_FLAVOR_ORIGIN_LOCAL                    = 0x00000000,
    ///For a class: The property was inherited from the parent class. For an instance: The property, while inherited
    ///from the parent class, has not been modified at the instance level.
    WBEM_FLAVOR_ORIGIN_PROPAGATED               = 0x00000020,
    ///The property is a standard system property.
    WBEM_FLAVOR_ORIGIN_SYSTEM                   = 0x00000040,
    WBEM_FLAVOR_MASK_ORIGIN                     = 0x00000060,
    WBEM_FLAVOR_NOT_AMENDED                     = 0x00000000,
    ///The qualifier is not required in the basic class definition and can be moved to the amendment to be localized.
    WBEM_FLAVOR_AMENDED                         = 0x00000080,
    WBEM_FLAVOR_MASK_AMENDED                    = 0x00000080,
}

///Contains flags used to define a query or enumerator.
alias WBEM_QUERY_FLAG_TYPE = int;
enum : int
{
    ///Include the specified class and all subclasses.
    WBEM_FLAG_DEEP      = 0x00000000,
    ///Include only the specified class, not any subclasses.
    WBEM_FLAG_SHALLOW   = 0x00000001,
    ///Used for prototyping. It does not execute the query and instead returns an object that looks like a typical
    ///result object.
    WBEM_FLAG_PROTOTYPE = 0x00000002,
}

///Contains flags used for setting security access levels.
alias WBEM_SECURITY_FLAGS = int;
enum : int
{
    ///Enables the account and grants the user read permissions. This is a default access right for all users and
    ///corresponds to the Enable Account permission on the Security tab of the WMI Control. For more information, see
    ///Setting Namespace Security with the WMI Control.
    WBEM_ENABLE            = 0x00000001,
    ///Allows the execution of methods. Providers can perform additional access checks. This is a default access right
    ///for all users and corresponds to the Execute Methods permission on the Security tab of the WMI Control.
    WBEM_METHOD_EXECUTE    = 0x00000002,
    ///Allows a user account to write to classes in the WMI repository as well as instances. A user cannot write to
    ///system classes. Only members of the Administrators group have this permission. <b>WBEM_FULL_WRITE_REP</b>
    ///corresponds to the Full Write permission on the Security tab of the WMI Control.
    WBEM_FULL_WRITE_REP    = 0x00000004,
    ///Allows you to write data to instances only, not classes. A user cannot write classes to the WMI repository. Only
    ///members of the Administrators group have this right. <b>WBEM_PARTIAL_WRITE_REP</b> corresponds to the Partial
    ///Write permission on the Security tab of the WMI Control.
    WBEM_PARTIAL_WRITE_REP = 0x00000008,
    ///Allows writing classes and instances to providers. Note that providers can do additional access checks when
    ///impersonating a user. This is a default access right for all users and corresponds to the Provider Write
    ///permission on the Security tab of the WMI Control.
    WBEM_WRITE_PROVIDER    = 0x00000010,
    ///Allows a user account to remotely perform any operations allowed by the permissions described above. Only members
    ///of the Administrators group have this right. <b>WBEM_REMOTE_ACCESS</b> corresponds to the Remote Enable
    ///permission on the Security tab of the WMI Control.
    WBEM_REMOTE_ACCESS     = 0x00000020,
    ///Specifies that a consumer can subscribe to the events delivered to a sink. Used in
    ///IWbemEventSink::SetSinkSecurity.
    WBEM_RIGHT_SUBSCRIBE   = 0x00000040,
    ///Specifies that the account can publish events to the instance of __EventFilter that defines the event filter for
    ///a permanent consumer. Available in wbemcli.h.
    WBEM_RIGHT_PUBLISH     = 0x00000080,
}

alias tag_WBEM_LIMITATION_FLAG_TYPE = int;
enum : int
{
    WBEM_FLAG_EXCLUDE_OBJECT_QUALIFIERS   = 0x00000010,
    WBEM_FLAG_EXCLUDE_PROPERTY_QUALIFIERS = 0x00000020,
}

///Contains flags to control the execution of the IWbemClassObject::GetObjectText method.
alias WBEM_TEXT_FLAG_TYPE = int;
enum : int
{
    ///Present qualifiers without propagation or flavor information.
    WBEM_FLAG_NO_FLAVORS = 0x00000001,
}

///Contains flags that define the comparison to perform when using the IWbemClassObject::CompareTo method.
alias WBEM_COMPARISON_FLAG = int;
enum : int
{
    ///Compare all features.
    WBEM_COMPARISON_INCLUDE_ALL     = 0x00000000,
    ///Ignore all qualifiers (including <b>Key</b> and <b>Dynamic</b>) in comparison.
    WBEM_FLAG_IGNORE_QUALIFIERS     = 0x00000001,
    ///Ignore the source of the objects, namely the server and the namespace they came from, in comparison to other
    ///objects.
    WBEM_FLAG_IGNORE_OBJECT_SOURCE  = 0x00000002,
    ///Ignore default values of properties. This flag is only meaningful when comparing classes.
    WBEM_FLAG_IGNORE_DEFAULT_VALUES = 0x00000004,
    ///Assume that the objects being compared are instances of the same class. Consequently, this flag compares
    ///instance-related information only. Use this flag to optimize performance. If the objects are not of the same
    ///class, the results are undefined.
    WBEM_FLAG_IGNORE_CLASS          = 0x00000008,
    ///Compare string values in a case-insensitive manner. This applies both to strings and to qualifier values.
    ///Property and qualifier names are always compared in a case-insensitive manner whether this flag is specified or
    ///not.
    WBEM_FLAG_IGNORE_CASE           = 0x00000010,
    WBEM_FLAG_IGNORE_FLAVOR         = 0x00000020,
}

alias tag_WBEM_LOCKING = int;
enum : int
{
    WBEM_FLAG_ALLOW_READ = 0x00000001,
}

///The <b>CIMTYPE_ENUMERATION</b> enumeration defines values that specify different CIM data types. All the values in
///the enumeration are types defined by the Distributed Management Task Force (DMTF). For more information about the
///DMTF and the CIM data types, see http://www.dmtf.org/standards/cim/cim_spec_v22.
alias CIMTYPE_ENUMERATION = int;
enum : int
{
    ///An illegal value.
    CIM_ILLEGAL    = 0x00000fff,
    ///An empty (null) value.
    CIM_EMPTY      = 0x00000000,
    ///An 8-bit signed integer.
    CIM_SINT8      = 0x00000010,
    ///An 8-bit unsigned integer.
    CIM_UINT8      = 0x00000011,
    ///A 16-bit signed integer.
    CIM_SINT16     = 0x00000002,
    ///A 16-bit unsigned integer.
    CIM_UINT16     = 0x00000012,
    ///A 32-bit signed integer.
    CIM_SINT32     = 0x00000003,
    ///A 32-bit unsigned integer.
    CIM_UINT32     = 0x00000013,
    ///A 64-bit signed integer.
    CIM_SINT64     = 0x00000014,
    ///A 64-bit unsigned integer.
    CIM_UINT64     = 0x00000015,
    ///A 32-bit real number.
    CIM_REAL32     = 0x00000004,
    ///A 64-bit real number.
    CIM_REAL64     = 0x00000005,
    ///A Boolean value.
    CIM_BOOLEAN    = 0x0000000b,
    ///A string value.
    CIM_STRING     = 0x00000008,
    ///A DateTime value.
    CIM_DATETIME   = 0x00000065,
    ///Reference (__Path) of another Object.
    CIM_REFERENCE  = 0x00000066,
    ///A 16-bit character value.
    CIM_CHAR16     = 0x00000067,
    ///An Object value.
    CIM_OBJECT     = 0x0000000d,
    CIM_FLAG_ARRAY = 0x00002000,
}

///Contains flags used for the IWbemBackupRestore::Restore method and the IWbemBackupRestoreEx::Restore method.
alias WBEM_BACKUP_RESTORE_FLAGS = int;
enum : int
{
    ///Does not shut down active clients; returns an error if there are any.
    WBEM_FLAG_BACKUP_RESTORE_DEFAULT        = 0x00000000,
    WBEM_FLAG_BACKUP_RESTORE_FORCE_SHUTDOWN = 0x00000001,
}

///Contains flags that modify the behavior of refresher methods.
alias WBEM_REFRESHER_FLAGS = int;
enum : int
{
    ///If the connection is broken, the refresher attempts to reconnect to the provider automatically.
    WBEM_FLAG_REFRESH_AUTO_RECONNECT    = 0x00000000,
    ///If the connection is broken, the refresher does not attempt to reconnect to the provider automatically.
    WBEM_FLAG_REFRESH_NO_AUTO_RECONNECT = 0x00000001,
}

alias tag_WBEM_SHUTDOWN_FLAGS = int;
enum : int
{
    WBEM_SHUTDOWN_UNLOAD_COMPONENT = 0x00000001,
    WBEM_SHUTDOWN_WMI              = 0x00000002,
    WBEM_SHUTDOWN_OS               = 0x00000003,
}

alias tag_WBEMSTATUS_FORMAT = int;
enum : int
{
    WBEMSTATUS_FORMAT_NEWLINE    = 0x00000000,
    WBEMSTATUS_FORMAT_NO_NEWLINE = 0x00000001,
}

///Defines some limit values.
alias WBEM_LIMITS = int;
enum : int
{
    WBEM_MAX_IDENTIFIER      = 0x00001000,
    WBEM_MAX_QUERY           = 0x00004000,
    WBEM_MAX_PATH            = 0x00002000,
    WBEM_MAX_OBJECT_NESTING  = 0x00000040,
    WBEM_MAX_USER_PROPERTIES = 0x00000400,
}

///Contains error and status codes returned by methods in the WMI API.
alias WBEMSTATUS = int;
enum : int
{
    WBEM_NO_ERROR                             = 0x00000000,
    WBEM_S_NO_ERROR                           = 0x00000000,
    WBEM_S_SAME                               = 0x00000000,
    WBEM_S_FALSE                              = 0x00000001,
    WBEM_S_ALREADY_EXISTS                     = 0x00040001,
    WBEM_S_RESET_TO_DEFAULT                   = 0x00040002,
    WBEM_S_DIFFERENT                          = 0x00040003,
    WBEM_S_TIMEDOUT                           = 0x00040004,
    WBEM_S_NO_MORE_DATA                       = 0x00040005,
    WBEM_S_OPERATION_CANCELLED                = 0x00040006,
    WBEM_S_PENDING                            = 0x00040007,
    WBEM_S_DUPLICATE_OBJECTS                  = 0x00040008,
    WBEM_S_ACCESS_DENIED                      = 0x00040009,
    WBEM_S_PARTIAL_RESULTS                    = 0x00040010,
    WBEM_S_SOURCE_NOT_AVAILABLE               = 0x00040017,
    WBEM_E_FAILED                             = 0x80041001,
    WBEM_E_NOT_FOUND                          = 0x80041002,
    WBEM_E_ACCESS_DENIED                      = 0x80041003,
    WBEM_E_PROVIDER_FAILURE                   = 0x80041004,
    WBEM_E_TYPE_MISMATCH                      = 0x80041005,
    WBEM_E_OUT_OF_MEMORY                      = 0x80041006,
    WBEM_E_INVALID_CONTEXT                    = 0x80041007,
    WBEM_E_INVALID_PARAMETER                  = 0x80041008,
    WBEM_E_NOT_AVAILABLE                      = 0x80041009,
    WBEM_E_CRITICAL_ERROR                     = 0x8004100a,
    WBEM_E_INVALID_STREAM                     = 0x8004100b,
    WBEM_E_NOT_SUPPORTED                      = 0x8004100c,
    WBEM_E_INVALID_SUPERCLASS                 = 0x8004100d,
    WBEM_E_INVALID_NAMESPACE                  = 0x8004100e,
    WBEM_E_INVALID_OBJECT                     = 0x8004100f,
    WBEM_E_INVALID_CLASS                      = 0x80041010,
    WBEM_E_PROVIDER_NOT_FOUND                 = 0x80041011,
    WBEM_E_INVALID_PROVIDER_REGISTRATION      = 0x80041012,
    WBEM_E_PROVIDER_LOAD_FAILURE              = 0x80041013,
    WBEM_E_INITIALIZATION_FAILURE             = 0x80041014,
    WBEM_E_TRANSPORT_FAILURE                  = 0x80041015,
    WBEM_E_INVALID_OPERATION                  = 0x80041016,
    WBEM_E_INVALID_QUERY                      = 0x80041017,
    WBEM_E_INVALID_QUERY_TYPE                 = 0x80041018,
    WBEM_E_ALREADY_EXISTS                     = 0x80041019,
    WBEM_E_OVERRIDE_NOT_ALLOWED               = 0x8004101a,
    WBEM_E_PROPAGATED_QUALIFIER               = 0x8004101b,
    WBEM_E_PROPAGATED_PROPERTY                = 0x8004101c,
    WBEM_E_UNEXPECTED                         = 0x8004101d,
    WBEM_E_ILLEGAL_OPERATION                  = 0x8004101e,
    WBEM_E_CANNOT_BE_KEY                      = 0x8004101f,
    WBEM_E_INCOMPLETE_CLASS                   = 0x80041020,
    WBEM_E_INVALID_SYNTAX                     = 0x80041021,
    WBEM_E_NONDECORATED_OBJECT                = 0x80041022,
    WBEM_E_READ_ONLY                          = 0x80041023,
    WBEM_E_PROVIDER_NOT_CAPABLE               = 0x80041024,
    WBEM_E_CLASS_HAS_CHILDREN                 = 0x80041025,
    WBEM_E_CLASS_HAS_INSTANCES                = 0x80041026,
    WBEM_E_QUERY_NOT_IMPLEMENTED              = 0x80041027,
    WBEM_E_ILLEGAL_NULL                       = 0x80041028,
    WBEM_E_INVALID_QUALIFIER_TYPE             = 0x80041029,
    WBEM_E_INVALID_PROPERTY_TYPE              = 0x8004102a,
    WBEM_E_VALUE_OUT_OF_RANGE                 = 0x8004102b,
    WBEM_E_CANNOT_BE_SINGLETON                = 0x8004102c,
    WBEM_E_INVALID_CIM_TYPE                   = 0x8004102d,
    WBEM_E_INVALID_METHOD                     = 0x8004102e,
    WBEM_E_INVALID_METHOD_PARAMETERS          = 0x8004102f,
    WBEM_E_SYSTEM_PROPERTY                    = 0x80041030,
    WBEM_E_INVALID_PROPERTY                   = 0x80041031,
    WBEM_E_CALL_CANCELLED                     = 0x80041032,
    WBEM_E_SHUTTING_DOWN                      = 0x80041033,
    WBEM_E_PROPAGATED_METHOD                  = 0x80041034,
    WBEM_E_UNSUPPORTED_PARAMETER              = 0x80041035,
    WBEM_E_MISSING_PARAMETER_ID               = 0x80041036,
    WBEM_E_INVALID_PARAMETER_ID               = 0x80041037,
    WBEM_E_NONCONSECUTIVE_PARAMETER_IDS       = 0x80041038,
    WBEM_E_PARAMETER_ID_ON_RETVAL             = 0x80041039,
    WBEM_E_INVALID_OBJECT_PATH                = 0x8004103a,
    WBEM_E_OUT_OF_DISK_SPACE                  = 0x8004103b,
    WBEM_E_BUFFER_TOO_SMALL                   = 0x8004103c,
    WBEM_E_UNSUPPORTED_PUT_EXTENSION          = 0x8004103d,
    WBEM_E_UNKNOWN_OBJECT_TYPE                = 0x8004103e,
    WBEM_E_UNKNOWN_PACKET_TYPE                = 0x8004103f,
    WBEM_E_MARSHAL_VERSION_MISMATCH           = 0x80041040,
    WBEM_E_MARSHAL_INVALID_SIGNATURE          = 0x80041041,
    WBEM_E_INVALID_QUALIFIER                  = 0x80041042,
    WBEM_E_INVALID_DUPLICATE_PARAMETER        = 0x80041043,
    WBEM_E_TOO_MUCH_DATA                      = 0x80041044,
    WBEM_E_SERVER_TOO_BUSY                    = 0x80041045,
    WBEM_E_INVALID_FLAVOR                     = 0x80041046,
    WBEM_E_CIRCULAR_REFERENCE                 = 0x80041047,
    WBEM_E_UNSUPPORTED_CLASS_UPDATE           = 0x80041048,
    WBEM_E_CANNOT_CHANGE_KEY_INHERITANCE      = 0x80041049,
    WBEM_E_CANNOT_CHANGE_INDEX_INHERITANCE    = 0x80041050,
    WBEM_E_TOO_MANY_PROPERTIES                = 0x80041051,
    WBEM_E_UPDATE_TYPE_MISMATCH               = 0x80041052,
    WBEM_E_UPDATE_OVERRIDE_NOT_ALLOWED        = 0x80041053,
    WBEM_E_UPDATE_PROPAGATED_METHOD           = 0x80041054,
    WBEM_E_METHOD_NOT_IMPLEMENTED             = 0x80041055,
    WBEM_E_METHOD_DISABLED                    = 0x80041056,
    WBEM_E_REFRESHER_BUSY                     = 0x80041057,
    WBEM_E_UNPARSABLE_QUERY                   = 0x80041058,
    WBEM_E_NOT_EVENT_CLASS                    = 0x80041059,
    WBEM_E_MISSING_GROUP_WITHIN               = 0x8004105a,
    WBEM_E_MISSING_AGGREGATION_LIST           = 0x8004105b,
    WBEM_E_PROPERTY_NOT_AN_OBJECT             = 0x8004105c,
    WBEM_E_AGGREGATING_BY_OBJECT              = 0x8004105d,
    WBEM_E_UNINTERPRETABLE_PROVIDER_QUERY     = 0x8004105f,
    WBEM_E_BACKUP_RESTORE_WINMGMT_RUNNING     = 0x80041060,
    WBEM_E_QUEUE_OVERFLOW                     = 0x80041061,
    WBEM_E_PRIVILEGE_NOT_HELD                 = 0x80041062,
    WBEM_E_INVALID_OPERATOR                   = 0x80041063,
    WBEM_E_LOCAL_CREDENTIALS                  = 0x80041064,
    WBEM_E_CANNOT_BE_ABSTRACT                 = 0x80041065,
    WBEM_E_AMENDED_OBJECT                     = 0x80041066,
    WBEM_E_CLIENT_TOO_SLOW                    = 0x80041067,
    WBEM_E_NULL_SECURITY_DESCRIPTOR           = 0x80041068,
    WBEM_E_TIMED_OUT                          = 0x80041069,
    WBEM_E_INVALID_ASSOCIATION                = 0x8004106a,
    WBEM_E_AMBIGUOUS_OPERATION                = 0x8004106b,
    WBEM_E_QUOTA_VIOLATION                    = 0x8004106c,
    WBEM_E_RESERVED_001                       = 0x8004106d,
    WBEM_E_RESERVED_002                       = 0x8004106e,
    WBEM_E_UNSUPPORTED_LOCALE                 = 0x8004106f,
    WBEM_E_HANDLE_OUT_OF_DATE                 = 0x80041070,
    WBEM_E_CONNECTION_FAILED                  = 0x80041071,
    WBEM_E_INVALID_HANDLE_REQUEST             = 0x80041072,
    WBEM_E_PROPERTY_NAME_TOO_WIDE             = 0x80041073,
    WBEM_E_CLASS_NAME_TOO_WIDE                = 0x80041074,
    WBEM_E_METHOD_NAME_TOO_WIDE               = 0x80041075,
    WBEM_E_QUALIFIER_NAME_TOO_WIDE            = 0x80041076,
    WBEM_E_RERUN_COMMAND                      = 0x80041077,
    WBEM_E_DATABASE_VER_MISMATCH              = 0x80041078,
    WBEM_E_VETO_DELETE                        = 0x80041079,
    WBEM_E_VETO_PUT                           = 0x8004107a,
    WBEM_E_INVALID_LOCALE                     = 0x80041080,
    WBEM_E_PROVIDER_SUSPENDED                 = 0x80041081,
    WBEM_E_SYNCHRONIZATION_REQUIRED           = 0x80041082,
    WBEM_E_NO_SCHEMA                          = 0x80041083,
    WBEM_E_PROVIDER_ALREADY_REGISTERED        = 0x80041084,
    WBEM_E_PROVIDER_NOT_REGISTERED            = 0x80041085,
    WBEM_E_FATAL_TRANSPORT_ERROR              = 0x80041086,
    WBEM_E_ENCRYPTED_CONNECTION_REQUIRED      = 0x80041087,
    WBEM_E_PROVIDER_TIMED_OUT                 = 0x80041088,
    WBEM_E_NO_KEY                             = 0x80041089,
    WBEM_E_PROVIDER_DISABLED                  = 0x8004108a,
    WBEMESS_E_REGISTRATION_TOO_BROAD          = 0x80042001,
    WBEMESS_E_REGISTRATION_TOO_PRECISE        = 0x80042002,
    WBEMESS_E_AUTHZ_NOT_PRIVILEGED            = 0x80042003,
    WBEMMOF_E_EXPECTED_QUALIFIER_NAME         = 0x80044001,
    WBEMMOF_E_EXPECTED_SEMI                   = 0x80044002,
    WBEMMOF_E_EXPECTED_OPEN_BRACE             = 0x80044003,
    WBEMMOF_E_EXPECTED_CLOSE_BRACE            = 0x80044004,
    WBEMMOF_E_EXPECTED_CLOSE_BRACKET          = 0x80044005,
    WBEMMOF_E_EXPECTED_CLOSE_PAREN            = 0x80044006,
    WBEMMOF_E_ILLEGAL_CONSTANT_VALUE          = 0x80044007,
    WBEMMOF_E_EXPECTED_TYPE_IDENTIFIER        = 0x80044008,
    WBEMMOF_E_EXPECTED_OPEN_PAREN             = 0x80044009,
    WBEMMOF_E_UNRECOGNIZED_TOKEN              = 0x8004400a,
    WBEMMOF_E_UNRECOGNIZED_TYPE               = 0x8004400b,
    WBEMMOF_E_EXPECTED_PROPERTY_NAME          = 0x8004400c,
    WBEMMOF_E_TYPEDEF_NOT_SUPPORTED           = 0x8004400d,
    WBEMMOF_E_UNEXPECTED_ALIAS                = 0x8004400e,
    WBEMMOF_E_UNEXPECTED_ARRAY_INIT           = 0x8004400f,
    WBEMMOF_E_INVALID_AMENDMENT_SYNTAX        = 0x80044010,
    WBEMMOF_E_INVALID_DUPLICATE_AMENDMENT     = 0x80044011,
    WBEMMOF_E_INVALID_PRAGMA                  = 0x80044012,
    WBEMMOF_E_INVALID_NAMESPACE_SYNTAX        = 0x80044013,
    WBEMMOF_E_EXPECTED_CLASS_NAME             = 0x80044014,
    WBEMMOF_E_TYPE_MISMATCH                   = 0x80044015,
    WBEMMOF_E_EXPECTED_ALIAS_NAME             = 0x80044016,
    WBEMMOF_E_INVALID_CLASS_DECLARATION       = 0x80044017,
    WBEMMOF_E_INVALID_INSTANCE_DECLARATION    = 0x80044018,
    WBEMMOF_E_EXPECTED_DOLLAR                 = 0x80044019,
    WBEMMOF_E_CIMTYPE_QUALIFIER               = 0x8004401a,
    WBEMMOF_E_DUPLICATE_PROPERTY              = 0x8004401b,
    WBEMMOF_E_INVALID_NAMESPACE_SPECIFICATION = 0x8004401c,
    WBEMMOF_E_OUT_OF_RANGE                    = 0x8004401d,
    WBEMMOF_E_INVALID_FILE                    = 0x8004401e,
    WBEMMOF_E_ALIASES_IN_EMBEDDED             = 0x8004401f,
    WBEMMOF_E_NULL_ARRAY_ELEM                 = 0x80044020,
    WBEMMOF_E_DUPLICATE_QUALIFIER             = 0x80044021,
    WBEMMOF_E_EXPECTED_FLAVOR_TYPE            = 0x80044022,
    WBEMMOF_E_INCOMPATIBLE_FLAVOR_TYPES       = 0x80044023,
    WBEMMOF_E_MULTIPLE_ALIASES                = 0x80044024,
    WBEMMOF_E_INCOMPATIBLE_FLAVOR_TYPES2      = 0x80044025,
    WBEMMOF_E_NO_ARRAYS_RETURNED              = 0x80044026,
    WBEMMOF_E_MUST_BE_IN_OR_OUT               = 0x80044027,
    WBEMMOF_E_INVALID_FLAGS_SYNTAX            = 0x80044028,
    WBEMMOF_E_EXPECTED_BRACE_OR_BAD_TYPE      = 0x80044029,
    WBEMMOF_E_UNSUPPORTED_CIMV22_QUAL_VALUE   = 0x8004402a,
    WBEMMOF_E_UNSUPPORTED_CIMV22_DATA_TYPE    = 0x8004402b,
    WBEMMOF_E_INVALID_DELETEINSTANCE_SYNTAX   = 0x8004402c,
    WBEMMOF_E_INVALID_QUALIFIER_SYNTAX        = 0x8004402d,
    WBEMMOF_E_QUALIFIER_USED_OUTSIDE_SCOPE    = 0x8004402e,
    WBEMMOF_E_ERROR_CREATING_TEMP_FILE        = 0x8004402f,
    WBEMMOF_E_ERROR_INVALID_INCLUDE_FILE      = 0x80044030,
    WBEMMOF_E_INVALID_DELETECLASS_SYNTAX      = 0x80044031,
}

///Defines the valid object text formats to be used by SWbemObjectEx.GetText_.
alias WMI_OBJ_TEXT = int;
enum : int
{
    ///XML format conforming to the DMTF (Distributed Management Task Force) CIM document type definition (DTD) version
    ///2.0.
    WMI_OBJ_TEXT_CIM_DTD_2_0 = 0x00000001,
    ///XML format as defined by the extended WMI version of DMTF CIM DTD version 2.0. Using this value enables
    ///WMI-specific extensions, such as embedded objects or scope.
    WMI_OBJ_TEXT_WMI_DTD_2_0 = 0x00000002,
    ///Deprecated. Do not use.
    WMI_OBJ_TEXT_WMI_EXT1    = 0x00000003,
    ///Deprecated. Do not use.
    WMI_OBJ_TEXT_WMI_EXT2    = 0x00000004,
    ///Deprecated. Do not use.
    WMI_OBJ_TEXT_WMI_EXT3    = 0x00000005,
    ///Deprecated. Do not use.
    WMI_OBJ_TEXT_WMI_EXT4    = 0x00000006,
    ///Deprecated. Do not use.
    WMI_OBJ_TEXT_WMI_EXT5    = 0x00000007,
    ///Deprecated. Do not use.
    WMI_OBJ_TEXT_WMI_EXT6    = 0x00000008,
    ///Deprecated. Do not use.
    WMI_OBJ_TEXT_WMI_EXT7    = 0x00000009,
    ///Deprecated. Do not use.
    WMI_OBJ_TEXT_WMI_EXT8    = 0x0000000a,
    ///Deprecated. Do not use.
    WMI_OBJ_TEXT_WMI_EXT9    = 0x0000000b,
    ///Deprecated. Do not use.
    WMI_OBJ_TEXT_WMI_EXT10   = 0x0000000c,
    WMI_OBJ_TEXT_LAST        = 0x0000000d,
}

///Contains option flags for IMofCompiler methods.
alias WBEM_COMPILER_OPTIONS = int;
enum : int
{
    WBEM_FLAG_CHECK_ONLY       = 0x00000001,
    WBEM_FLAG_AUTORECOVER      = 0x00000002,
    WBEM_FLAG_WMI_CHECK        = 0x00000004,
    WBEM_FLAG_CONSOLE_PRINT    = 0x00000008,
    WBEM_FLAG_DONT_ADD_TO_LIST = 0x00000010,
    WBEM_FLAG_SPLIT_FILES      = 0x00000020,
    WBEM_FLAG_STORE_FILE       = 0x00000100,
}

///Contains flags for the IWbemLocator::ConnectServer method.
alias WBEM_CONNECT_OPTIONS = int;
enum : int
{
    ///Reserved for internal use. Do not use.
    WBEM_FLAG_CONNECT_REPOSITORY_ONLY = 0x00000040,
    ///The call returns in 2 minutes or less whether successful or not.
    WBEM_FLAG_CONNECT_USE_MAX_WAIT    = 0x00000080,
    WBEM_FLAG_CONNECT_PROVIDERS       = 0x00000100,
}

///Used to control access checks on callbacks when using the IWbemUnsecuredApartment::CreateSinkStub method.
alias WBEM_UNSECAPP_FLAG_TYPE = int;
enum : int
{
    ///Unsecapp.exe reads the registry key UnsecAppAccessControlDefault to determine if it should authenticate
    ///callbacks.
    WBEM_FLAG_UNSECAPP_DEFAULT_CHECK_ACCESS = 0x00000000,
    ///Unsecapp.exe authenticates callbacks regardless of the setting of the registry key UnsecAppAccessControlDefault.
    WBEM_FLAG_UNSECAPP_CHECK_ACCESS         = 0x00000001,
    WBEM_FLAG_UNSECAPP_DONT_CHECK_ACCESS    = 0x00000002,
}

alias tag_WBEM_INFORMATION_FLAG_TYPE = int;
enum : int
{
    WBEM_FLAG_SHORT_NAME = 0x00000001,
    WBEM_FLAG_LONG_NAME  = 0x00000002,
}

alias tag_WBEM_PROVIDER_REQUIREMENTS_TYPE = int;
enum : int
{
    WBEM_REQUIREMENTS_START_POSTFILTER      = 0x00000000,
    WBEM_REQUIREMENTS_STOP_POSTFILTER       = 0x00000001,
    WBEM_REQUIREMENTS_RECHECK_SUBSCRIPTIONS = 0x00000002,
}

alias tag_WBEM_EXTRA_RETURN_CODES = int;
enum : int
{
    WBEM_S_INITIALIZED         = 0x00000000,
    WBEM_S_LIMITED_SERVICE     = 0x00043001,
    WBEM_S_INDIRECTLY_UPDATED  = 0x00043002,
    WBEM_S_SUBJECT_TO_SDS      = 0x00043003,
    WBEM_E_RETRY_LATER         = 0x80043001,
    WBEM_E_RESOURCE_CONTENTION = 0x80043002,
}

alias tag_WBEM_PROVIDER_FLAGS = int;
enum : int
{
    WBEM_FLAG_OWNER_UPDATE = 0x00010000,
}

alias tag_WBEM_BATCH_TYPE = int;
enum : int
{
    WBEM_FLAG_BATCH_IF_NEEDED = 0x00000000,
    WBEM_FLAG_MUST_BATCH      = 0x00000001,
    WBEM_FLAG_MUST_NOT_BATCH  = 0x00000002,
}

///The WbemChangeFlagEnum constants define how a write operation to a class or an instance is carried out. A write
///operation is executed by SWbemObject.Put_ or by SWbemServicesEx.Put_. These flags are used by <b>SWbemObject.Put_</b>
///and SWbemObject.PutAsync_. The WMI scripting type library, WbemDisp.tlb, defines these constants. Visual Basic
///applications can access this library; script languages must use the value of the constant directly, unless they use
///the Windows Script Host (WSH) XML file format. For more information, see Using the WMI Scripting Type Library.
enum WbemChangeFlagEnum : int
{
    ///Causes the class or instance to be created, if it does not exist, or overwritten if it already exists.
    wbemChangeFlagCreateOrUpdate   = 0x00000000,
    ///Causes the call to update. The class or instance must exist for the call to be successful.
    wbemChangeFlagUpdateOnly       = 0x00000001,
    ///Used for creation only. The call will fail if the class or instance already exists.
    wbemChangeFlagCreateOnly       = 0x00000002,
    ///Allows a class to be updated if there are no derived classes and there are no instances for that class. It also
    ///allows updates in all cases if the change is just to non-important qualifiers (for example, the Description
    ///qualifier). If the class has instances, the update fails. This flag is used for compatibility with previous
    ///versions of WMI.
    wbemChangeFlagUpdateCompatible = 0x00000000,
    ///Allows updates of classes even if there are child classes as long as the change does not cause any conflicts with
    ///child classes. An example of an update this flag would allow would be to add a new property to the base class not
    ///previously mentioned in any of the child classes. If the class has instances, the update fails.
    wbemChangeFlagUpdateSafeMode   = 0x00000020,
    ///Forces updates of classes when conflicting child classes exist. An example of an update this flag forces would be
    ///if a class qualifier was defined in a child class, and the base class tried to add the same qualifier in conflict
    ///with the existing one. In the force mode, this conflict is resolved by deleting the qualifier in the child class.
    ///If the class has instances, the update fails. Using the force mode to update a static class results in deletion
    ///of all instances of that class. Force update on provider classes does not delete instances of the class.
    wbemChangeFlagUpdateForceMode  = 0x00000040,
    ///<b>: </b>Notifies the operating system to return a failure on put operations to any invalid system instances.
    ///Examples of such instances are event-related instances, such as filters, bindings, or providers. By default, if
    ///these instances are invalid, the put operation reports success but an error is reported in the log.
    wbemChangeFlagStrongValidation = 0x00000080,
    wbemChangeFlagAdvisory         = 0x00010000,
}

///The <b>WbemFlagEnum</b> enumeration defines constants that are used by SWbemServices.ExecQuery,
///SWbemServices.ExecQueryAsync, SWbemServices.SubclassesOf, and SWbemServices.InstancesOf. The WMI scripting type
///library, wbemdisp.tlb, defines these constants. Visual Basic applications can access this library; script languages
///must use the value of the constant directly, unless they use the Windows Script Host (WSH) XML file format. For more
///information, see Using the WMI Scripting Type Library.
enum WbemFlagEnum : int
{
    ///Causes the call to return immediately.
    wbemFlagReturnImmediately    = 0x00000010,
    ///Causes this call to block until the call has completed.
    wbemFlagReturnWhenComplete   = 0x00000000,
    ///Causes WMI to retain pointers to objects of the enumeration until the client releases the enumerator.
    wbemFlagBidirectional        = 0x00000000,
    ///Causes a forward-only enumerator to be returned. Use this flag in combination with
    ///<b>wbemFlagReturnImmediately</b> to request semisynchronous access. For more information, see Calling a Method.
    ///You can only iterate (as in a VBScript For Each statement) through a forward-only enumerator one time. The memory
    ///containing the instances is released by WMI so that the enumerator cannot be rewound. Therefore, the
    ///SWbemObjectSet.Count method cannot be used since it requires rewinding the enumerator. Forward-only enumerators
    ///are generally much faster and use less memory than conventional enumerators, but they do not allow calls to
    ///SWbemObject.Clone.
    wbemFlagForwardOnly          = 0x00000020,
    ///This flag must not be set, and must be ignored on receipt.
    wbemFlagNoErrorObject        = 0x00000040,
    ///Causes asynchronous calls to return an error object in the event of an error.
    wbemFlagReturnErrorObject    = 0x00000000,
    ///Causes asynchronous calls to send status updates to the SWbemSink.OnProgress event handler for your object sink.
    wbemFlagSendStatus           = 0x00000080,
    ///Prevents asynchronous calls from sending status updates to the SWbemSink.OnProgress event handler for your object
    ///sink.
    wbemFlagDontSendStatus       = 0x00000000,
    wbemFlagEnsureLocatable      = 0x00000100,
    wbemFlagDirectRead           = 0x00000200,
    wbemFlagSendOnlySelected     = 0x00000000,
    ///Causes WMI to return class amendment data along with the base class definition. For more information about
    ///amended qualifiers, see Localizing WMI Class Information.
    wbemFlagUseAmendedQualifiers = 0x00020000,
    wbemFlagGetDefault           = 0x00000000,
    wbemFlagSpawnInstance        = 0x00000001,
    wbemFlagUseCurrentTime       = 0x00000001,
}

///The <b>WbemQueryFlagEnum</b> constants define the depth of enumeration or query, which determines how many objects
///are returned by a call. These constants are used by SWbemServices.SubclassesOf, SWbemServices.InstancesOf,
///SWbemObject.Subclasses_, and SWbemObject.Instances_. The WMI scripting type library, wbemdisp.tlb, defines these
///constants. Visual Basic applications can access this library; script languages must use the value of the constant
///directly, unless they use Windows Script Host (WSH) XML file format. For more information, see Using the WMI
///Scripting Type Library.
enum WbemQueryFlagEnum : int
{
    ///Forces recursive enumeration into all subclasses derived from the specified parent class. The parent class itself
    ///is not returned in the enumeration.
    wbemQueryFlagDeep      = 0x00000000,
    ///Forces the enumeration to include only immediate subclasses of the specified parent class.
    wbemQueryFlagShallow   = 0x00000001,
    ///Used for prototyping. It stops the query from happening and instead returns an object that look like a typical
    ///result object.
    wbemQueryFlagPrototype = 0x00000002,
}

///The WbemTextFlagEnum constant defines the content of generated object text and is used by SWbemObject.GetObjectText_.
///The WMI scripting type library, wbemdisp.tlb, defines these constants. Visual Basic applications can access this
///library;. script languages must use the value of the constant directly, unless they use Windows Script Host (WSH) XML
///file format. For more information, see Using the WMI Scripting Type Library.
enum WbemTextFlagEnum : int
{
    ///Excludes qualifier flavors from the object text.
    wbemTextFlagNoFlavors = 0x00000001,
}

///The WbemTimeout constant defines the time-out constants. This constant is used by SWbemEventSource.NextEvent. The WMI
///scripting type library, wbemdisp.tlb, defines these constants. Visual Basic applications can access this library;
///script languages must use the value of the constant directly, unless they use Windows Script Host (WSH) XML file
///format. For more information, see Using the WMI Scripting Type Library.
enum WbemTimeout : int
{
    ///Use for parameters that use a time-out value such as <i>iTimeoutMs</i> for ISWbemServices.ExecNotificationQuery
    ///and the call will not return unless an event is received.
    wbemTimeoutInfinite = 0xffffffff,
}

///The WbemComparisonFlagEnum constants define the settings for object comparison and are used by
///SWbemObject.CompareTo_. The WMI scripting type library, wbemdisp.tlb, defines these constants. Visual Basic
///applications can access this library; script languages must use the value of the constant directly, unless they use
///the Windows Script Host (WSH) XML file format. For more information, see Using the WMI Scripting Type Library.
enum WbemComparisonFlagEnum : int
{
    ///Used to compare all properties, qualifiers, and flavors.
    wbemComparisonFlagIncludeAll          = 0x00000000,
    ///Ignores all qualifiers (including Key and Dynamic) in comparison.
    wbemComparisonFlagIgnoreQualifiers    = 0x00000001,
    ///Ignores the source of the objects, namely the server and the namespace they came from, in comparison to other
    ///objects.
    wbemComparisonFlagIgnoreObjectSource  = 0x00000002,
    ///Ignores default values of properties (only meaningful when comparing classes).
    wbemComparisonFlagIgnoreDefaultValues = 0x00000004,
    ///Instructs the system to assume that the objects being compared are instances of the same class. Consequently,
    ///this constant compares instance-related information only. Use to optimize performance. If the objects are not of
    ///the same class, the results will be undefined.
    wbemComparisonFlagIgnoreClass         = 0x00000008,
    ///Compares string values in a case-insensitive manner. This applies both to strings and to qualifier values.
    ///Property and qualifier names are always compared in a case-insensitive manner whether this constant is specified
    ///or not.
    wbemComparisonFlagIgnoreCase          = 0x00000010,
    ///Ignore qualifier flavors. This constant still takes qualifier values into account, but ignores flavor
    ///distinctions such as propagation rules and override restrictions.
    wbemComparisonFlagIgnoreFlavor        = 0x00000020,
}

///The WbemCimtypeEnum constants define the valid CIM types of a property value. The WMI scripting type library,
///wbemdisp.tlb, defines these constants. Visual Basic applications can access this library; script languages must use
///the value of the constant directly, unless they use the Windows Script Host (WSH) XML file format. For more
///information, see Using the WMI Scripting Type Library.
enum WbemCimtypeEnum : int
{
    ///Signed 8-bit integer
    wbemCimtypeSint8     = 0x00000010,
    ///Unsigned 8-bit integer
    wbemCimtypeUint8     = 0x00000011,
    ///Signed 16-bit integer
    wbemCimtypeSint16    = 0x00000002,
    ///Unsigned 16-bit integer
    wbemCimtypeUint16    = 0x00000012,
    ///Signed 32-bit integer
    wbemCimtypeSint32    = 0x00000003,
    ///Unsigned 32-bit integer
    wbemCimtypeUint32    = 0x00000013,
    ///Signed 64-bit integer
    wbemCimtypeSint64    = 0x00000014,
    ///Unsigned 64-bit integer
    wbemCimtypeUint64    = 0x00000015,
    ///32-bit real number
    wbemCimtypeReal32    = 0x00000004,
    ///64-bit real number
    wbemCimtypeReal64    = 0x00000005,
    ///Boolean value
    wbemCimtypeBoolean   = 0x0000000b,
    ///String
    wbemCimtypeString    = 0x00000008,
    ///Date/time value
    wbemCimtypeDatetime  = 0x00000065,
    ///Reference to a CIM object
    wbemCimtypeReference = 0x00000066,
    ///16-bit character
    wbemCimtypeChar16    = 0x00000067,
    ///CIM object
    wbemCimtypeObject    = 0x0000000d,
}

///The WbemErrorEnum constants define the errors that may be returned by Scripting API for WMI calls. The WMI scripting
///type library Wbemdisp.tlb defines these constants. Visual Basic applications can access this library; script
///languages must use the value of the constant directly, unless they use the Windows Script Host (WSH) XML file format.
///For more information, see Using the WMI Scripting Type Library. Other languages may have different names for these
///values, see WMI Error Constants and WBEMSTATUS.
enum WbemErrorEnum : int
{
    ///The call was successful.
    wbemNoErr                           = 0x00000000,
    ///The call failed.
    wbemErrFailed                       = 0x80041001,
    ///The object could not be found.
    wbemErrNotFound                     = 0x80041002,
    ///The current user does not have permission to perform the action.
    wbemErrAccessDenied                 = 0x80041003,
    ///The provider has failed at some time other than during initialization.
    wbemErrProviderFailure              = 0x80041004,
    ///A type mismatch occurred.
    wbemErrTypeMismatch                 = 0x80041005,
    ///There was not enough memory for the operation.
    wbemErrOutOfMemory                  = 0x80041006,
    ///The SWbemNamedValue object is not valid.
    wbemErrInvalidContext               = 0x80041007,
    ///One of the parameters to the call is not correct.
    wbemErrInvalidParameter             = 0x80041008,
    ///The resource, typically a remote server, is not currently available.
    wbemErrNotAvailable                 = 0x80041009,
    ///An internal, critical, and unexpected error occurred. Report this error to Microsoft Technical Support.
    wbemErrCriticalError                = 0x8004100a,
    ///One or more network packets were corrupted during a remote session.
    wbemErrInvalidStream                = 0x8004100b,
    ///The feature or operation is not supported.
    wbemErrNotSupported                 = 0x8004100c,
    ///The parent class specified is not valid.
    wbemErrInvalidSuperclass            = 0x8004100d,
    ///The namespace specified could not be found.
    wbemErrInvalidNamespace             = 0x8004100e,
    ///The specified instance is not valid.
    wbemErrInvalidObject                = 0x8004100f,
    ///The specified class is not valid.
    wbemErrInvalidClass                 = 0x80041010,
    ///A provider referenced in the schema does not have a corresponding registration.
    wbemErrProviderNotFound             = 0x80041011,
    ///A provider referenced in the schema has an incorrect or incomplete registration. This error may be caused by a
    ///missing pragma namespace command in the MOF file used to register the provider, resulting in the provider being
    ///registered in the wrong WMI namespace. This error may also be caused by a corrupt repository, which may be fixed
    ///by deleting it and recompiling the MOF files.
    wbemErrInvalidProviderRegistration  = 0x80041012,
    ///COM cannot locate a provider referenced in the schema. This error may be caused by any of the following: The
    ///provider is using a WMI DLL that does not match the .lib fileused when the provider was built. The provider's DLL
    ///or any of the DLLs on which it depends is corrupt. The provider failed to export DllRegisterServer. An in-process
    ///provider was not registered using /regsvr32. An out-of-process provider was not registered using /regserver.
    wbemErrProviderLoadFailure          = 0x80041013,
    ///A component, such as a provider, failed to initialize for internal reasons.
    wbemErrInitializationFailure        = 0x80041014,
    ///A networking error occurred, preventing normal operation.
    wbemErrTransportFailure             = 0x80041015,
    ///The requested operation is not valid. This error usually applies to invalid attempts to delete classes or
    ///properties.
    wbemErrInvalidOperation             = 0x80041016,
    ///The requested operation is not valid. This error usually applies to invalid attempts to delete classes or
    ///properties.
    wbemErrInvalidQuery                 = 0x80041017,
    ///The requested query language is not supported.
    wbemErrInvalidQueryType             = 0x80041018,
    ///In a put operation, the <b>wbemChangeFlagCreateOnly</b> flag was specified, but the instance already exists.
    wbemErrAlreadyExists                = 0x80041019,
    ///It is not possible to perform the add operation on this qualifier because the owning object does not permit
    ///overrides.
    wbemErrOverrideNotAllowed           = 0x8004101a,
    ///The user attempted to delete a qualifier that was not owned. The qualifier was inherited from a parent class.
    wbemErrPropagatedQualifier          = 0x8004101b,
    ///The user attempted to delete a property that was not owned. The property was inherited from a parent class.
    wbemErrPropagatedProperty           = 0x8004101c,
    ///The client made an unexpected and illegal sequence of calls, such as calling <b>EndEnumeration</b> before calling
    ///<b>BeginEnumeration</b>.
    wbemErrUnexpected                   = 0x8004101d,
    ///The user requested an illegal operation, such as spawning a class from an instance.
    wbemErrIllegalOperation             = 0x8004101e,
    ///There was an illegal attempt to specify a key qualifier on a property that cannot be a key. The keys are
    ///specified in the class definition for an object, and cannot be altered on a per-instance basis.
    wbemErrCannotBeKey                  = 0x8004101f,
    ///The current object is not a valid class definition. Either it is incomplete, or it has not been registered with
    ///WMI using SWbemObject.Put_.
    wbemErrIncompleteClass              = 0x80041020,
    ///The syntax of an input parameter is incorrect for the applicable data structure. For example, when a CIM datetime
    ///structure does not have the correct format when passed to SWbemDateTime.SetFileTime.
    wbemErrInvalidSyntax                = 0x80041021,
    ///Reserved for future use.
    wbemErrNondecoratedObject           = 0x80041022,
    ///The property that you are attempting to modify is read-only.
    wbemErrReadOnly                     = 0x80041023,
    ///The provider cannot perform the requested operation. This would include a query that is too complex, retrieving
    ///an instance, creating or updating a class, deleting a class, or enumerating a class.
    wbemErrProviderNotCapable           = 0x80041024,
    ///An attempt was made to make a change that would invalidate a subclass.
    wbemErrClassHasChildren             = 0x80041025,
    ///An attempt has been made to delete or modify a class that has instances.
    wbemErrClassHasInstances            = 0x80041026,
    ///Reserved for future use.
    wbemErrQueryNotImplemented          = 0x80041027,
    ///A value of Nothing was specified for a property that may not be Nothing, such as one that is marked by a Key,
    ///<b>Indexed</b>, or <b>Not_Null</b> qualifier.
    wbemErrIllegalNull                  = 0x80041028,
    ///The CIM type specified for a property is not valid.
    wbemErrInvalidQualifierType         = 0x80041029,
    ///The CIM type specified for a property is not valid.
    wbemErrInvalidPropertyType          = 0x8004102a,
    ///The request was made with an out-of-range value, or is incompatible with the type.
    wbemErrValueOutOfRange              = 0x8004102b,
    ///An illegal attempt was made to make a class singleton, such as when the class is derived from a non-singleton
    ///class.
    wbemErrCannotBeSingleton            = 0x8004102c,
    ///The CIM type specified is not valid.
    wbemErrInvalidCimType               = 0x8004102d,
    ///The requested method is not available.
    wbemErrInvalidMethod                = 0x8004102e,
    ///The parameters provided for the method are not valid.
    wbemErrInvalidMethodParameters      = 0x8004102f,
    ///There was an attempt to get qualifiers on a system property.
    wbemErrSystemProperty               = 0x80041030,
    ///The property type is not recognized.
    wbemErrInvalidProperty              = 0x80041031,
    ///An asynchronous process has been canceled internally or by the user. Note that due to the timing and nature of
    ///the asynchronous operation the operation may not have been truly canceled.
    wbemErrCallCancelled                = 0x80041032,
    ///The user has requested an operation while WMI is in the process of shutting down.
    wbemErrShuttingDown                 = 0x80041033,
    ///An attempt was made to reuse an existing method name from a parent class, and the signatures did not match.
    wbemErrPropagatedMethod             = 0x80041034,
    ///One or more parameter values, such as a query text, is too complex or unsupported. WMI is therefore requested to
    ///retry the operation with simpler parameters.
    wbemErrUnsupportedParameter         = 0x80041035,
    ///A parameter was missing from the method call.
    wbemErrMissingParameter             = 0x80041036,
    ///A method parameter has an ID qualifier that is not valid.
    wbemErrInvalidParameterId           = 0x80041037,
    ///One or more of the method parameters have ID qualifiers that are out of sequence.
    wbemErrNonConsecutiveParameterIds   = 0x80041038,
    ///The return value for a method has an ID qualifier.
    wbemErrParameterIdOnRetval          = 0x80041039,
    ///The specified object path was not valid.
    wbemErrInvalidObjectPath            = 0x8004103a,
    ///Disk is out of space or the 4 GB limit on WMI repository (CIM repository) size is reached.
    wbemErrOutOfDiskSpace               = 0x8004103b,
    ///The supplied buffer was too small to hold all the objects in the enumerator or to read a string property.
    wbemErrBufferTooSmall               = 0x8004103c,
    ///The provider does not support the requested put operation.
    wbemErrUnsupportedPutExtension      = 0x8004103d,
    ///An object with an incorrect type or version was encountered during marshaling.
    wbemErrUnknownObjectType            = 0x8004103e,
    ///A packet with an incorrect type or version was encountered during marshaling.
    wbemErrUnknownPacketType            = 0x8004103f,
    ///The packet has an unsupported version.
    wbemErrMarshalVersionMismatch       = 0x80041040,
    ///The packet appears to be corrupted.
    wbemErrMarshalInvalidSignature      = 0x80041041,
    ///An attempt has been made to mismatch qualifiers, such as putting [key] on an object instead of a property.
    wbemErrInvalidQualifier             = 0x80041042,
    ///A duplicate parameter has been declared in a CIM method.
    wbemErrInvalidDuplicateParameter    = 0x80041043,
    ///Reserved for future use.
    wbemErrTooMuchData                  = 0x80041044,
    ///A call to IWbemObjectSink::Indicate has failed. The provider may choose to refire the event.
    wbemErrServerTooBusy                = 0x80041045,
    ///The specified flavor was not valid.
    wbemErrInvalidFlavor                = 0x80041046,
    ///An attempt has been made to create a reference that is circular (for example, deriving a class from itself).
    wbemErrCircularReference            = 0x80041047,
    ///The specified class is not supported.
    wbemErrUnsupportedClassUpdate       = 0x80041048,
    ///An attempt was made to change a key when instances or subclasses are already using the key.
    wbemErrCannotChangeKeyInheritance   = 0x80041049,
    ///An attempt was made to change an index when instances or subclasses are already using the index.
    wbemErrCannotChangeIndexInheritance = 0x80041050,
    ///An attempt was made to create more properties than the current version of the class supports.
    wbemErrTooManyProperties            = 0x80041051,
    ///A property was redefined with a conflicting type in a derived class.
    wbemErrUpdateTypeMismatch           = 0x80041052,
    ///An attempt was made in a derived class to override a non-overrideable qualifier.
    wbemErrUpdateOverrideNotAllowed     = 0x80041053,
    ///A method was redeclared with a conflicting signature in a derived class.
    wbemErrUpdatePropagatedMethod       = 0x80041054,
    ///An attempt was made to execute a method not marked with [implemented] in any relevant class.
    wbemErrMethodNotImplemented         = 0x80041055,
    ///An attempt was made to execute a method marked with [disabled].
    wbemErrMethodDisabled               = 0x80041056,
    ///The refresher is busy with another operation.
    wbemErrRefresherBusy                = 0x80041057,
    ///The filtering query is syntactically not valid.
    wbemErrUnparsableQuery              = 0x80041058,
    ///The FROM clause of a filtering query references a class that is not an event class (not derived from __Event).
    wbemErrNotEventClass                = 0x80041059,
    ///A GROUP BY clause was used without the corresponding GROUP WITHIN clause.
    wbemErrMissingGroupWithin           = 0x8004105a,
    ///A GROUP BY clause was used. Aggregation on all properties is not supported.
    wbemErrMissingAggregationList       = 0x8004105b,
    ///Dot notation was used on a property that is not an embedded object.
    wbemErrPropertyNotAnObject          = 0x8004105c,
    ///A GROUP BY clause references a property that is an embedded object without using dot notation.
    wbemErrAggregatingByObject          = 0x8004105d,
    ///An event provider registration query (__EventProviderRegistration) did not specify the classes for which events
    ///were provided.
    wbemErrUninterpretableProviderQuery = 0x8004105f,
    ///An request was made to back up or restore the repository while WMI was using it.
    wbemErrBackupRestoreWinmgmtRunning  = 0x80041060,
    ///The asynchronous delivery queue overflowed due to the event consumer being too slow.
    wbemErrQueueOverflow                = 0x80041061,
    ///The operation failed because the client did not have the necessary security privilege.
    wbemErrPrivilegeNotHeld             = 0x80041062,
    ///The operator is not valid for this property type.
    wbemErrInvalidOperator              = 0x80041063,
    ///The user specified a username, password or authority for a local connection. The user must use a blank
    ///username/password and rely on default security.
    wbemErrLocalCredentials             = 0x80041064,
    ///The class was made abstract when its parent class is not abstract.
    wbemErrCannotBeAbstract             = 0x80041065,
    ///An amended object was put without the <b>wbemFlagUseAmendedQualifiers</b> flag being specified.
    wbemErrAmendedObject                = 0x80041066,
    ///The client was not retrieving objects quickly enough from an enumeration. This constant is returned when a client
    ///creates an enumeration object but does not retrieve objects from the enumerator in a timely fashion, causing the
    ///enumerator's object caches to get backed up.
    wbemErrClientTooSlow                = 0x80041067,
    ///A null security descriptor was used.
    wbemErrNullSecurityDescriptor       = 0x80041068,
    ///The operation timed out.
    wbemErrTimeout                      = 0x80041069,
    ///The association being used is not valid.
    wbemErrInvalidAssociation           = 0x8004106a,
    ///The operation was ambiguous.
    wbemErrAmbiguousOperation           = 0x8004106b,
    ///WMI is taking up too much memory. This could be caused either by low memory availability or excessive memory
    ///consumption by WMI.
    wbemErrQuotaViolation               = 0x8004106c,
    ///The operation resulted in a transaction conflict.
    wbemErrTransactionConflict          = 0x8004106d,
    ///The transaction forced a rollback.
    wbemErrForcedRollback               = 0x8004106e,
    ///The locale used in the call is not supported.
    wbemErrUnsupportedLocale            = 0x8004106f,
    ///The object handle is out of date.
    wbemErrHandleOutOfDate              = 0x80041070,
    ///Indicates that the connection to the SQL database failed.
    wbemErrConnectionFailed             = 0x80041071,
    ///The handle request was not valid.
    wbemErrInvalidHandleRequest         = 0x80041072,
    ///The property name contains more than 255 characters.
    wbemErrPropertyNameTooWide          = 0x80041073,
    ///The class name contains more than 255 characters.
    wbemErrClassNameTooWide             = 0x80041074,
    ///The method name contains more than 255 characters.
    wbemErrMethodNameTooWide            = 0x80041075,
    ///The qualifier name contains more than 255 characters.
    wbemErrQualifierNameTooWide         = 0x80041076,
    ///Indicates that an SQL command should be rerun because there is a deadlock in SQL. This can be returned only when
    ///data is being stored in an SQL database.
    wbemErrRerunCommand                 = 0x80041077,
    ///The database version does not match the version that the repository driver processes.
    wbemErrDatabaseVerMismatch          = 0x80041078,
    ///WMI cannot do the put operation because the provider does not allow it.
    wbemErrVetoPut                      = 0x80041079,
    ///WMI cannot do the delete operation because the provider does not allow it.
    wbemErrVetoDelete                   = 0x8004107a,
    ///The specified locale identifier was not valid for the operation.
    wbemErrInvalidLocale                = 0x80041080,
    ///The provider is suspended.
    wbemErrProviderSuspended            = 0x80041081,
    ///The object must be committed and retrieved again before the requested operation can succeed. This constant is
    ///returned when an object must be committed and re-retrieved to see the property value.
    wbemErrSynchronizationRequired      = 0x80041082,
    ///The operation cannot be completed because no schema is available.
    wbemErrNoSchema                     = 0x80041083,
    ///The provider registration cannot be done because the provider is already registered.
    wbemErrProviderAlreadyRegistered    = 0x80041084,
    ///The provider for the requested data is not registered.
    wbemErrProviderNotRegistered        = 0x80041085,
    ///A fatal transport error occurred and other transport will not be attempted.
    wbemErrFatalTransportError          = 0x80041086,
    ///The client connection to WINMGMT must be encrypted for this operation. The IWbemServices proxy security settings
    ///should be adjusted and the operation retried.
    wbemErrEncryptedConnectionRequired  = 0x80041087,
    ///The provider registration overlaps with the system event domain.
    wbemErrRegistrationTooBroad         = 0x80042001,
    ///A WITHIN clause was not used in this query.
    wbemErrRegistrationTooPrecise       = 0x80042002,
    ///Automation-specific error.
    wbemErrTimedout                     = 0x80043001,
    ///The user deleted an override default value for the current class. The default value for this property in the
    ///parent class has been reactivated. An automation-specific error.
    wbemErrResetToDefault               = 0x80043002,
}

///The <b>WbemAuthenticationLevelEnum</b> constants define the security authentication levels. These constants are used
///with SWbemSecurity and in moniker connections to WMI. The WMI scripting type library, wbemdisp.tlb, defines these
///constants. Visual Basic applications can access this library. Script languages must use one of the following: <ul>
///<li> The short name. For example, for <b>WbemAuthenticationLevelPktPrivacy</b> use "PktPrivacy". ```vb strComputer =
///"RemoteComputer" Set objWMIServices = GetObject("WINMGMTS:" _ & "{authenticationLevel=pktPrivacy}!\\" _ & strComputer
///& "\ROOT\CIMV2") ``` </li> <li> Windows Script Host (WSH) XML file format in the script. For example, this means that
///the script can use the <b>WbemAuthenticationLevelPkt</b> constant directly. The following WSH script sets the
///authentication level. To run the script, save the text in a file with a .wsf extension. ```vb <?xml version="1.0"
///encoding="US-ASCII"?> <job> <reference object="WbemScripting.SWbemLocator"/> <script language="VBScript"> set service
///= GetObject("winmgmts:") ' Following line uses a symbolic ' constant from the WMI type library
///service.Security_.authenticationLevel = _ WbemAuthenticationLevelPktPrivacy </script> </job> ``` For more
///information, see Using the WMI Scripting Type Library.</li> </ul>
enum WbemAuthenticationLevelEnum : int
{
    wbemAuthenticationLevelDefault      = 0x00000000,
    wbemAuthenticationLevelNone         = 0x00000001,
    wbemAuthenticationLevelConnect      = 0x00000002,
    wbemAuthenticationLevelCall         = 0x00000003,
    wbemAuthenticationLevelPkt          = 0x00000004,
    wbemAuthenticationLevelPktIntegrity = 0x00000005,
    wbemAuthenticationLevelPktPrivacy   = 0x00000006,
}

///The WbemImpersonationLevelEnum constants define the security impersonation levels. These constants are used with
///SWbemSecurity. The WMI scripting type library, wbemdisp.tlb, defines these constants. Visual Basic applications can
///access this library. Script languages must use one of the following: <ul> <li> The short name. For example, for
///<b>wbemImpersonationLevelImpersonate</b> use "Impersonate". The following VBScript code example uses the short name.
///```vb Set objWMIService = GetObject("winmgmts:" _ & "{impersonationLevel=Impersonate}!\\" _ & strComputer &
///"\root\cimv2") ``` </li> <li> Windows Script Host (WSH) XML file format in the script. For example, this means that
///the script can use the <b>wbemImpersonationLevelImpersonate</b> constant directly. The following WSH script sets the
///impersonation level. To run the script, save the text in a file with a .wsf extension. ```vb <?xml version="1.0"
///encoding="US-ASCII"?> <job> <reference object="WbemScripting.SWbemLocator"/> <script language="VBScript"> set service
///= GetObject("winmgmts:") ' Following line uses a symbolic ' constant from the WMI type library
///service.Security_.impersonationLevel = _ wbemImpersonationLevelDelegate </script> </job> ``` For more information,
///see Using the WMI Scripting Type Library. </li> </ul>
enum WbemImpersonationLevelEnum : int
{
    ///Short name: Anonymous Hides the credentials of the caller. Calls to WMI may fail with this impersonation level.
    wbemImpersonationLevelAnonymous   = 0x00000001,
    ///Short name: Identify Allows objects to query the credentials of the caller. Calls to WMI may fail with this
    ///impersonation level.
    wbemImpersonationLevelIdentify    = 0x00000002,
    ///Short name: Impersonate Allows objects to use the credentials of the caller. This is the recommended
    ///impersonation level for Scripting API for WMI calls.
    wbemImpersonationLevelImpersonate = 0x00000003,
    ///Short name: Delegate Allows objects to permit other objects to use the credentials of the caller. This
    ///impersonation will work with Scripting API for WMI calls but may constitute an unnecessary security risk.
    wbemImpersonationLevelDelegate    = 0x00000004,
}

///The WbemPrivilegeEnum constants define privileges. These constants are used with SWbemSecurity to grant the
///privileges required for some operations. For more information, see Privilege Constants. The WMI scripting type
///library, wbemdisp.tlb defines these constants. Microsoft Visual Basic applications can access this library; script
///languages must use the value of the constant directly, unless they use Windows Script Host (WSH) XML file format. For
///more information, see Using the WMI Scripting Type Library.
enum WbemPrivilegeEnum : int
{
    ///Required to create a primary token.
    wbemPrivilegeCreateToken          = 0x00000001,
    ///Required to assign the primary token of a process.
    wbemPrivilegePrimaryToken         = 0x00000002,
    ///Required to lock physical pages in memory.
    wbemPrivilegeLockMemory           = 0x00000003,
    ///Required to increase the quota assigned to a process.
    wbemPrivilegeIncreaseQuota        = 0x00000004,
    ///Required to create a machine account.
    wbemPrivilegeMachineAccount       = 0x00000005,
    ///Identifies its holder as part of the trusted computer base. Some trusted, protected subsystems are granted this
    ///privilege.
    wbemPrivilegeTcb                  = 0x00000006,
    ///Required to perform a number of security-related functions, such as controlling and viewing audit messages. This
    ///privilege identifies its holder as a security operator.
    wbemPrivilegeSecurity             = 0x00000007,
    ///Required to take ownership of an object without being granted discretionary access. This privilege allows the
    ///owner value to be set only to those values that the holder may legitimately assign as the owner of an object.
    wbemPrivilegeTakeOwnership        = 0x00000008,
    ///Required to load or unload a device driver.
    wbemPrivilegeLoadDriver           = 0x00000009,
    ///Required to gather profiling information for the entire system.
    wbemPrivilegeSystemProfile        = 0x0000000a,
    ///Required to modify the system time.
    wbemPrivilegeSystemtime           = 0x0000000b,
    ///Required to gather profiling information for a single process.
    wbemPrivilegeProfileSingleProcess = 0x0000000c,
    ///Required to increase the base priority of a process.
    wbemPrivilegeIncreaseBasePriority = 0x0000000d,
    ///Required to create a paging file.
    wbemPrivilegeCreatePagefile       = 0x0000000e,
    ///Required to create a permanent object.
    wbemPrivilegeCreatePermanent      = 0x0000000f,
    ///Required to perform backup operations.
    wbemPrivilegeBackup               = 0x00000010,
    ///Required to perform restore operations. This privilege enables you to set any valid user or group security
    ///identifier (SID) as the owner of an object.
    wbemPrivilegeRestore              = 0x00000011,
    ///Required to shut down a local system.
    wbemPrivilegeShutdown             = 0x00000012,
    ///Required to debug a process.
    wbemPrivilegeDebug                = 0x00000013,
    ///Required to generate audit-log entries.
    wbemPrivilegeAudit                = 0x00000014,
    ///Required to modify the nonvolatile RAM of systems that use this type of memory to store configuration
    ///information.
    wbemPrivilegeSystemEnvironment    = 0x00000015,
    ///Required to receive notifications of changes to files or directories. This privilege also causes the system to
    ///skip all traversal access checks. It is enabled by default for all users.
    wbemPrivilegeChangeNotify         = 0x00000016,
    ///Required to shut down a system using a network request.
    wbemPrivilegeRemoteShutdown       = 0x00000017,
    ///Required to remove a computer from a docking station.
    wbemPrivilegeUndock               = 0x00000018,
    ///Required to synchronize directory service data.
    wbemPrivilegeSyncAgent            = 0x00000019,
    ///Required to enable computer and user accounts to be trusted for delegation.
    wbemPrivilegeEnableDelegation     = 0x0000001a,
    ///Required to perform volume maintenance tasks.
    wbemPrivilegeManageVolume         = 0x0000001b,
}

///The WbemObjectTextFormatEnum constants define the valid object text formats to be used by SWbemObjectEx.GetText_. The
///WMI scripting type library, wbemdisp.tlb, defines these constants. Visual Basic applications can access this library;
///script languages must use the value of the constant directly, unless they use Windows Script Host (WSH) XML file
///format. For more information, see Using the WMI Scripting Type Library.
enum WbemObjectTextFormatEnum : int
{
    ///XML format conforming to the DMTF (Distributed Management Task Force) CIM document type definition (DTD) version
    ///2.0.
    wbemObjectTextFormatCIMDTD20 = 0x00000001,
    ///XML format as defined by the extended WMI version of DMTF CIM DTD version 2.0. Using this value enables
    ///WMI-specific extensions, such as embedded objects or scope.
    wbemObjectTextFormatWMIDTD20 = 0x00000002,
}

///The WbemConnectOptionsEnum constant defines a security flag that is used as a parameter in calls to the
///SWbemLocator.ConnectServer method when a connection to WMI on a remote machine is failing.
enum WbemConnectOptionsEnum : int
{
    ///Shortens the timeout for the SWbemLocator.ConnectServer method call to two minutes.
    wbemConnectFlagUseMaxWait = 0x00000080,
}

// Structs


///The <b>SWbemQueryQualifiedName</b> structure stores property names for the IWbemQuery::GetAnalysis method.
struct SWbemQueryQualifiedName
{
    ///Unused. Always 1 (one).
    uint   m_uVersion;
    ///Unused. Always 1 (one).
    uint   m_uTokenType;
    ///Number of elements in the list of names. For example, for the "propName" property, <b>m_uNameListSize</b> is 1
    ///(one) and <b>m_ppszNameList</b> is "propName".
    uint   m_uNameListSize;
    ///List of property names. For example, for the "propName" property, <b>m_uNameListSize</b> is 1 (one) and
    ///<b>m_ppszNameList</b> is "propName".
    PWSTR* m_ppszNameList;
    ///Unused. Always <b>false</b>.
    BOOL   m_bArraysUsed;
    ///Unused. Always <b>NULL</b>.
    BOOL*  m_pbArrayElUsed;
    ///Unused. Always <b>NULL</b>.
    uint*  m_puArrayIndex;
}

union tag_SWbemRpnConst
{
    const(PWSTR) m_pszStrVal;
    BOOL         m_bBoolVal;
    int          m_lLongVal;
    uint         m_uLongVal;
    double       m_dblVal;
    long         m_lVal64;
    long         m_uVal64;
}

///The <b>SWbemRpnQueryToken</b> structure represents the query tokens in a WMIQ_ANALYSIS_RPN_SEQUENCE type query. An
///example of a query token is the following: j &gt; 4.
struct SWbemRpnQueryToken
{
    ///Unused. Always 1.
    uint              m_uVersion;
    ///Type of token this instance represents.
    uint              m_uTokenType;
    ///If the <b>m_uTokenType</b> member is <b>WMIQ_RPN_TOKEN_EXPRESSION</b>, <b>m_uSubexpressionShape</b> bitmask value
    ///specifies the shape of the expression.
    uint              m_uSubexpressionShape;
    ///This field can have the value 0 (zero), or one of the following values.
    uint              m_uOperator;
    ///If there are two property names in a token, <b>m_pRightIdent</b> is used to identify the right property name.
    SWbemQueryQualifiedName* m_pRightIdent;
    ///If there are two property names in a token <b>m_pLeftIdent</b> is used to identify the left property name. If
    ///only one property name is present, it appears in this member.
    SWbemQueryQualifiedName* m_pLeftIdent;
    ///Apparent data type of the constant.
    uint              m_uConstApparentType;
    ///Value of the first constant. For more information, see SWbemRpnConst.
    tag_SWbemRpnConst m_Const;
    ///Type of second constant. The fields <b>m_uConst2ApparentType</b> and <b>m_uConst2</b> are used only for BETWEEN
    ///phrases.
    uint              m_uConst2ApparentType;
    ///Value of the second constant. The fields <b>m_uConst2ApparentType</b> and <b>m_uConst2</b> are used only for
    ///BETWEEN phrases. For more information, see SWbemRpnConst.
    tag_SWbemRpnConst m_Const2;
    ///Specifies a function on the right of the operator in a WHERE clause. If there is no function on the right of the
    ///operator in this token, this field is <b>NULL</b>.
    const(PWSTR)      m_pszRightFunc;
    ///Specifies a function on the left of the operator in a WHERE clause. If there is no function on the left of the
    ///operator in this token, this field is <b>NULL</b>.
    const(PWSTR)      m_pszLeftFunc;
}

struct tag_SWbemRpnTokenList
{
    uint m_uVersion;
    uint m_uTokenType;
    uint m_uNumTokens;
}

///The <b>SWbemRpnEncodedQuery</b> structure contains information from the IWbemQuery::GetAnalysis method when you use
///the <b>WMIQ_ANALYSIS_RPN_SEQUENCE</b> analysis type. Not all the fields in the structure are used actively, because
///some are reserved for future use.
struct SWbemRpnEncodedQuery
{
    ///Unused. Value is always 1.
    uint                 m_uVersion;
    ///Unused. Value is always 0 (zero).
    uint                 m_uTokenType;
    ///Unused. Value is always 0 (zero).
    ulong                m_uParsedFeatureMask;
    ///Unused. Value is always 0 (zero).
    uint                 m_uDetectedArraySize;
    ///Unused. Value is always <b>NULL</b>.
    uint*                m_puDetectedFeatures;
    ///Number of elements listed in a SELECT clause. For example, in the statement <code>SELECT a,b,c FROM d</code>,
    ///<b>m_uSelectListSize</b> is the value 3 (a, b and c).
    uint                 m_uSelectListSize;
    ///Structure used to store property names. This field is used with the <b>m_uSelectListSize</b> field. For example,
    ///in the statement <code>SELECT a,b,c FROM d</code>, <b>m_uSelectListSize</b> is 3, and the <b>m_ppszNameList</b>
    ///field of the <b>m_ppSelectList</b> structure contains the strings "a", "b" and "c". For more information, see
    ///SWbemQueryQualifiedName.
    SWbemQueryQualifiedName** m_ppSelectList;
    ///Bitmap used to indicate the form of the FROM clause.
    uint                 m_uFromTargetType;
    ///Optional FROM path. If not used this field is <b>NULL</b>.
    const(PWSTR)         m_pszOptionalFromPath;
    ///Number of items in the FROM clause of the SELECT statement. For example, in the statement, <code>SELECT * FROM a,
    ///b</code>, the value of <b>m_uFromListSize</b> is 2.
    uint                 m_uFromListSize;
    ///Pointer to a list of strings. Each string is one element of the FROM clause of a SELECT statement. For example,
    ///in the statement <code>SELECT * FROM a, b</code>, the list contains the strings "a" and "b".
    PWSTR*               m_ppszFromList;
    ///Number of tokens in the WHERE clause. For example, in the statement <code>SELECT * FROM a, b WHERE c &lt; 1000
    ///AND d ISA e</code>, the value of <b>m_uWhereClauseSize</b> is 2 (the phrases <code>c &lt; 1000</code> and <code>d
    ///ISA e</code>).
    uint                 m_uWhereClauseSize;
    ///SWbemRpnQueryToken <code>SELECT * FROM a, b WHERE c &lt; 1000 AND d ISA e</code> <code>c &lt; 1000</code> <code>d
    ///ISA e</code> <code>AND</code>
    SWbemRpnQueryToken** m_ppRpnWhereClause;
    ///If there is a WITHIN clause, this field indicates the polling interval. If there is a GROUP WITHIN clause, this
    ///<b>m_dblWithinPolling</b> is unused.
    double               m_dblWithinPolling;
    ///Used if there is a GROUP WITHIN clause to indicate the interval over which to group results.
    double               m_dblWithinWindow;
    uint                 m_uOrderByListSize;
    PWSTR*               m_ppszOrderByList;
    uint*                m_uOrderDirectionEl;
}

struct tag_SWbemAnalysisMatrix
{
    uint         m_uVersion;
    uint         m_uMatrixType;
    const(PWSTR) m_pszProperty;
    uint         m_uPropertyType;
    uint         m_uEntries;
    void**       m_pValues;
    BOOL*        m_pbTruthTable;
}

struct tag_SWbemAnalysisMatrixList
{
    uint m_uVersion;
    uint m_uMatrixType;
    uint m_uNumMatrices;
    tag_SWbemAnalysisMatrix* m_pMatrices;
}

///The <b>SWbemAssocQueryInf</b> structure contains information from the IWbemQuery::GetAnalysis method when you use the
///<b>WMIQ_ANALYSIS_ASSOC_QUERY</b> analysis type.
struct SWbemAssocQueryInf
{
    ///Value must be 2.
    uint      m_uVersion;
    ///Value must be 2.
    uint      m_uAnalysisType;
    ///Bit values that indicate the features in a query.
    uint      m_uFeatureMask;
    ///Pointer to an IWbemPath object.
    IWbemPath m_pPath;
    ///String representation of the object path used in the query.
    PWSTR     m_pszPath;
    ///Text of the original query.
    PWSTR     m_pszQueryText;
    ///String representation of the result class. If there is no result class, this field is <b>NULL</b>.
    PWSTR     m_pszResultClass;
    ///String representation of the association class. If there is no result class, this field is <b>NULL</b>.
    PWSTR     m_pszAssocClass;
    ///String representation of the role. If there is no role, this field is <b>NULL</b>.
    PWSTR     m_pszRole;
    ///String representation of the result role. If there is no result role, this field is <b>NULL</b>.
    PWSTR     m_pszResultRole;
    ///String representation of the required qualifier. If no qualifiers are required, this field is <b>NULL</b>.
    PWSTR     m_pszRequiredQualifier;
    ///Pointer to a list of required association qualifiers.
    PWSTR     m_pszRequiredAssocQualifier;
}

///Describes an error for the IMofCompiler interface.
struct WBEM_COMPILE_STATUS_INFO
{
    ///TBD
    int     lPhaseError;
    ///The actual error code.
    HRESULT hRes;
    ///Object that is at fault.
    int     ObjectNum;
    ///First line number of the object.
    int     FirstLine;
    ///Last line number of the object.
    int     LastLine;
    ///Reserved.
    uint    dwOutFlags;
}

// Interfaces

@GUID("CF4CC405-E2C5-4DDD-B3CE-5E7582D8C9FA")
struct WbemDefPath;

@GUID("EAC8A024-21E2-4523-AD73-A71A0AA2F56A")
struct WbemQuery;

@GUID("4590F811-1D3A-11D0-891F-00AA004B2E24")
struct WbemLocator;

@GUID("674B6698-EE92-11D0-AD71-00C04FD8FDFF")
struct WbemContext;

@GUID("49BD2028-1523-11D1-AD79-00C04FD8FDFF")
struct UnsecuredApartment;

@GUID("9A653086-174F-11D2-B5F9-00104B703EFD")
struct WbemClassObject;

@GUID("6DAF9757-2E37-11D2-AEC9-00C04FB68820")
struct MofCompiler;

@GUID("EB87E1BD-3233-11D2-AEC9-00C04FB68820")
struct WbemStatusCodeText;

@GUID("C49E32C6-BC8B-11D2-85D4-00105A1F8304")
struct WbemBackupRestore;

@GUID("C71566F2-561E-11D1-AD87-00C04FD8FDFF")
struct WbemRefresher;

@GUID("8D1C559D-84F0-4BB3-A7D5-56A7435A9BA6")
struct WbemObjectTextSrc;

@GUID("CB8555CC-9128-11D1-AD9B-00C04FD8FDFF")
struct WbemAdministrativeLocator;

@GUID("CD184336-9128-11D1-AD9B-00C04FD8FDFF")
struct WbemAuthenticatedLocator;

@GUID("443E7B79-DE31-11D2-B340-00104BCC4B4A")
struct WbemUnauthenticatedLocator;

@GUID("4CFC7932-0F9D-4BEF-9C32-8EA2A6B56FCB")
struct WbemDecoupledRegistrar;

@GUID("F5F75737-2843-4F22-933D-C76A97CDA62F")
struct WbemDecoupledBasicEventProvider;

@GUID("76A64158-CB41-11D1-8B02-00600806D9B6")
struct SWbemLocator;

@GUID("9AED384E-CE8B-11D1-8B05-00600806D9B6")
struct SWbemNamedValueSet;

@GUID("5791BC26-CE9C-11D1-97BF-0000F81E849C")
struct SWbemObjectPath;

@GUID("C2FEEEAC-CFCD-11D1-8B05-00600806D9B6")
struct SWbemLastError;

@GUID("75718C9A-F029-11D1-A1AC-00C04FB6C223")
struct SWbemSink;

@GUID("47DFBE54-CF76-11D3-B38F-00105A1F473A")
struct SWbemDateTime;

@GUID("D269BF5C-D9C1-11D3-B38F-00105A1F473A")
struct SWbemRefresher;

@GUID("04B83D63-21AE-11D2-8B33-00600806D9B6")
struct SWbemServices;

@GUID("62E522DC-8CF3-40A8-8B2E-37D595651E40")
struct SWbemServicesEx;

@GUID("04B83D62-21AE-11D2-8B33-00600806D9B6")
struct SWbemObject;

@GUID("D6BDAFB2-9435-491F-BB87-6AA0F0BC31A2")
struct SWbemObjectEx;

@GUID("04B83D61-21AE-11D2-8B33-00600806D9B6")
struct SWbemObjectSet;

@GUID("04B83D60-21AE-11D2-8B33-00600806D9B6")
struct SWbemNamedValue;

@GUID("04B83D5F-21AE-11D2-8B33-00600806D9B6")
struct SWbemQualifier;

@GUID("04B83D5E-21AE-11D2-8B33-00600806D9B6")
struct SWbemQualifierSet;

@GUID("04B83D5D-21AE-11D2-8B33-00600806D9B6")
struct SWbemProperty;

@GUID("04B83D5C-21AE-11D2-8B33-00600806D9B6")
struct SWbemPropertySet;

@GUID("04B83D5B-21AE-11D2-8B33-00600806D9B6")
struct SWbemMethod;

@GUID("04B83D5A-21AE-11D2-8B33-00600806D9B6")
struct SWbemMethodSet;

@GUID("04B83D58-21AE-11D2-8B33-00600806D9B6")
struct SWbemEventSource;

@GUID("B54D66E9-2287-11D2-8B33-00600806D9B6")
struct SWbemSecurity;

@GUID("26EE67BC-5804-11D2-8B4A-00600806D9B6")
struct SWbemPrivilege;

@GUID("26EE67BE-5804-11D2-8B4A-00600806D9B6")
struct SWbemPrivilegeSet;

@GUID("8C6854BC-DE4B-11D3-B390-00105A1F473A")
struct SWbemRefreshableItem;

///The <b>IWbemPathKeyList</b> interface is used to access the details of the path keys.
@GUID("9AE62877-7544-4BB0-AA26-A13824659ED6")
interface IWbemPathKeyList : IUnknown
{
    ///The <b>IWbemPathKeyList::GetCount</b> method retrieves the number of keys in the path.
    ///Params:
    ///    puKeyCount = Number of keys.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call.
    ///    
    HRESULT GetCount(uint* puKeyCount);
    ///The <b>IWbemPathKeyList::SetKey</b> method sets the name or value pair for a key. If the key exists, it is
    ///replaced. If the name is empty, all existing keys are deleted.
    ///Params:
    ///    wszName = Key name, may be <b>NULL</b>.
    ///    uFlags = Reserved. Must be 0 (zero).
    ///    uCimType = CIMTYPE size.
    ///    pKeyVal = Pointer to the data. The data pointed to varies depending on the <i>uCimType</i> parameter.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call.
    ///    
    HRESULT SetKey(const(PWSTR) wszName, uint uFlags, uint uCimType, void* pKeyVal);
    ///The <b>IWbemPathKeyList::SetKey2</b> method sets the name or value pair for a key using variants. If the key
    ///exists, it is replaced.
    ///Params:
    ///    wszName = Key name, may be <b>NULL</b>.
    ///    uFlags = Reserved. Must be 0 (zero).
    ///    uCimType = CIMTYPE size.
    ///    pKeyVal = Pointer to a variant that contains the data.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call.
    ///    
    HRESULT SetKey2(const(PWSTR) wszName, uint uFlags, uint uCimType, VARIANT* pKeyVal);
    ///The <b>IWbemPathKeyList::GetKey</b> method retrieves a key's name or value. Keys are indexed from 0 (zero),
    ///though the order of the keys is not significant.
    ///Params:
    ///    uKeyIx = Key index beginning at 0 (zero).
    ///    uFlags = Reserved. Must be 0 (zero).
    ///    puNameBufSize = Caller sets this to the number of characters that the name buffer can hold. Upon success, this is set to the
    ///                    number of characters copied into the buffer including the terminating <b>NULL</b>.
    ///    pszKeyName = Buffer into which the name is to be copied. Because not all keys have a name, this parameter value would be
    ///                 <b>NULL</b> for an implicit key.
    ///    puKeyValBufSize = Caller sets this to the number of characters that the value buffer can hold. Upon success, this is set to the
    ///                      number of characters copied into the buffer including the <b>NULL</b> terminator.
    ///    pKeyVal = Buffer where data is to be copied.
    ///    puApparentCimType = Pointer to a long which is set to the CIM type.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call.
    ///    
    HRESULT GetKey(uint uKeyIx, uint uFlags, uint* puNameBufSize, PWSTR pszKeyName, uint* puKeyValBufSize, 
                   void* pKeyVal, uint* puApparentCimType);
    ///The <b>IWbemPathKeyList::GetKey2</b> method retrieves a key name or value, and returns the value as a
    ///<b>VARIANT</b>. A key is indexed from 0 (zero), but the key order is not significant.
    ///Params:
    ///    uKeyIx = Key index begins at 0 (zero).
    ///    uFlags = Reserved. Must be 0 (zero).
    ///    puNameBufSize = Caller sets this parameter to the number of characters that the name buffer can hold. When successful, this
    ///                    is set to the number of characters that are copied into the buffer—including the terminating <b>NULL</b>.
    ///    pszKeyName = Buffer into which the name is copied. Because not all keys have a name, this parameter value is <b>NULL</b>
    ///                 for an implicit key.
    ///    pKeyValue = Pointer to a variant that contains the key value.
    ///    puApparentCimType = Pointer to a long integer that is set to the CIM type.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> that indicates the status of the method call.
    ///    
    HRESULT GetKey2(uint uKeyIx, uint uFlags, uint* puNameBufSize, PWSTR pszKeyName, VARIANT* pKeyValue, 
                    uint* puApparentCimType);
    ///The <b>IWbemPathKeyList::RemoveKey</b> method removes the key that matches the <i>wszName</i> parameter.
    ///Params:
    ///    wszName = Name of the key to be removed.
    ///    uFlags = Reserved. Must be 0 (zero).
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call.
    ///    
    HRESULT RemoveKey(const(PWSTR) wszName, uint uFlags);
    ///The <b>IWbemPathKeyList::RemoveAllKeys</b> method removes all keys.
    ///Params:
    ///    uFlags = Reserved. Must be 0 (zero).
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call.
    ///    
    HRESULT RemoveAllKeys(uint uFlags);
    ///The <b>IWbemPathKeyList::MakeSingleton</b> method governs whether or not a key is singleton.
    ///Params:
    ///    bSet = If <b>TRUE</b>, the key becomes singleton. If <b>FALSE</b>, the key is no longer singleton.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call.
    ///    
    HRESULT MakeSingleton(ubyte bSet);
    ///The <b>IWbemPathKeyList::GetInfo</b> method retrieves the status bits for the key.
    ///Params:
    ///    uRequestedInfo = Reserved. Must be 0 (zero).
    ///    puResponse = Status for the key. The following bits indicate the values available.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call.
    ///    
    HRESULT GetInfo(uint uRequestedInfo, ulong* puResponse);
    ///The <b>IWbemPathKeyList::GetText</b> method retrieves the key list as text.
    ///Params:
    ///    lFlags = Flags which control the format of the text. The following list lists the valid flag values.
    ///    puBuffLength = Caller sets this to the number of characters that the buffer can hold. Upon success, this is set to the
    ///                   number of characters copied into the buffer, including the <b>NULL</b> terminator.
    ///    pszText = Buffer into which the text is copied.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call.
    ///    
    HRESULT GetText(int lFlags, uint* puBuffLength, PWSTR pszText);
}

///The <b>IWbemPath</b> interface is the primary interface for the object path parser and makes parsing a path available
///to programs in a standard way. This interface is the main interface for setting and retrieving path information. The
///following table lists the methods for <b>IWbemPath</b>.
@GUID("3BC15AF2-736C-477E-9E51-238AF8667DCC")
interface IWbemPath : IUnknown
{
    ///The <b>IWbemPath::SetText</b> method parses a path so that information on the path can be returned by the path
    ///parser. Typically, this is the first method called by users of the interface. The only case in which this is not
    ///the first method called is when the calling code is constructing the path by specifying each piece separately.
    ///Params:
    ///    uMode = Flag specifying the type of paths accepted.
    ///    pszPath = Path to be parsed.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call.
    ///    
    HRESULT SetText(uint uMode, const(PWSTR) pszPath);
    ///The <b>IWbemPath::GetText</b> method returns a textual representation of a path that has previously been placed
    ///into a parser object.
    ///Params:
    ///    lFlags = Flag which controls how the text is returned.
    ///    puBuffLength = Caller sets this to the size of <i>pszText</i>. If the method is successful, it sets <i>puBufferLength</i> to
    ///                   the number of wide characters used, including the terminating null character.
    ///    pszText = Textual representation of the path.
    ///Returns:
    ///    This method returns the following values.
    ///    
    HRESULT GetText(int lFlags, uint* puBuffLength, PWSTR pszText);
    ///The <b>IWbemPath::GetInfo</b> method returns details about a path that has been placed into a parser object.
    ///Params:
    ///    uRequestedInfo = Reserved for future use. Must be 0 (zero).
    ///    puResponse = Upon success, this bitmap is set to 0 (zero) or more bits in the following list.
    ///Returns:
    ///    This method returns one of the following values.
    ///    
    HRESULT GetInfo(uint uRequestedInfo, ulong* puResponse);
    ///The <b>IWbemPath::SetServer</b> method sets the server portion of the path.
    ///Params:
    ///    Name = New server name. <b>NULL</b> is an acceptable value.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call.
    ///    
    HRESULT SetServer(const(PWSTR) Name);
    ///The <b>IWbemPath::GetServer</b> method retrieves the server portion of the path.
    ///Params:
    ///    puNameBufLength = Upon input, this is the size in characters of the buffer pointed to by <i>pszName</i>. Upon return, this is
    ///                      the number of characters in the server name, including the <b>NULL</b> terminator.
    ///    pName = Server name.
    ///Returns:
    ///    This method returns the following values.
    ///    
    HRESULT GetServer(uint* puNameBufLength, PWSTR pName);
    ///The <b>IWbemPath::GetNamespaceCount</b> method returns the number of namespaces in the path.
    ///Params:
    ///    puCount = Number of namespaces in the path.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> with one of the following values.
    ///    
    HRESULT GetNamespaceCount(uint* puCount);
    ///The <b>IWbemPath::SetNamespace</b> method sets a namespace in a path using zero-based indexing to designate where
    ///in the path the namespace is positioned.
    ///Params:
    ///    uIndex = Index of where the namespace is to be put. The leftmost namespace in the path is index 0 (zero) with each
    ///             namespace to the right having a progressively higher index value. The maximum permitted value is the current
    ///             number of namespaces, because specifying that would add a namespace to the end as the namespaces have a
    ///             zero-based index.
    ///    pszName = Namespace name.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call.
    ///    
    HRESULT SetNamespaceAt(uint uIndex, const(PWSTR) pszName);
    ///The <b>IWbemPath::GetNamespaceAt</b> method retrieves a namespace based upon its index. The leftmost namespace in
    ///the path has an index of 0 with each namespace moving to the right having a progressively higher index value.
    ///Params:
    ///    uIndex = Index of the namespace to be read. The leftmost namespace in the path is index 0 with each namespace to the
    ///             right having a progressively higher index value. The maximum permitted value is one less than the current
    ///             number of namespaces.
    ///    puNameBufLength = Caller sets this to the number of characters the buffer can hold. Upon success, this is set to the number of
    ///                      characters copied into the buffer including the <b>NULL</b> terminator.
    ///    pName = Namespace name.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call.
    ///    
    HRESULT GetNamespaceAt(uint uIndex, uint* puNameBufLength, PWSTR pName);
    ///The <b>IWbemPath::RemoveNamespaceAt</b> method removes a namespace at a particular index. The leftmost namespace
    ///has an index value of 0 (zero), while namespaces to the right have progressively higher index values.
    ///Params:
    ///    uIndex = Zero-based index value of the namespace to be removed.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> with one of the following values.
    ///    
    HRESULT RemoveNamespaceAt(uint uIndex);
    ///The <b>IWbemPath::RemoveAllNamespaces</b> method removes the namespace portion of the path.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call.
    ///    
    HRESULT RemoveAllNamespaces();
    ///The <b>IWbemPath::GetScopeCount</b> method returns the number of scopes in the path.
    ///Params:
    ///    puCount = Number of scopes in the path. When there is a scope it is basically the class or key portion of the path.
    ///Returns:
    ///    This method returns the following values.
    ///    
    HRESULT GetScopeCount(uint* puCount);
    ///The <b>IWbemPath::SetScope</b> method sets a scope in the path based upon an index. The index is always 0 (zero)
    ///and the scope is the class or key portion of the path. This method also sets the class name.
    ///Params:
    ///    uIndex = Index of the scope.
    ///    pszClass = Class name of the scope.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call.
    ///    
    HRESULT SetScope(uint uIndex, PWSTR pszClass);
    HRESULT SetScopeFromText(uint uIndex, PWSTR pszText);
    ///The <b>IWbemPath::GetScope</b> method retrieves a scope based upon an index. This method retrieves the class name
    ///and a IWbemPathKeyList pointer so that the details of the keys can be retrieved.
    ///Params:
    ///    uIndex = Index of the scope.
    ///    puClassNameBufSize = Caller sets this to the number of characters that the buffer can hold. Upon success, this is set to the
    ///                         number of characters copied into the buffer including the <b>NULL</b> terminator.
    ///    pszClass = Buffer where the scope is to be copied.
    ///    pKeyList = Pointer to an IWbemPathKeyList object.
    ///Returns:
    ///    This method returns the following values.
    ///    
    HRESULT GetScope(uint uIndex, uint* puClassNameBufSize, PWSTR pszClass, IWbemPathKeyList* pKeyList);
    ///The <b>IWbemPath::GetScopeAsText</b> method retrieves a scope in text format based on an index.
    ///Params:
    ///    uIndex = Index of the scope.
    ///    puTextBufSize = Caller sets this to the number of characters that the buffer can hold. After success this is set to the
    ///                    number of characters copied into the buffer including the <b>NULL</b> terminator.
    ///    pszText = Buffer where the scope is to be copied.
    ///Returns:
    ///    This method returns the following values.
    ///    
    HRESULT GetScopeAsText(uint uIndex, uint* puTextBufSize, PWSTR pszText);
    ///The <b>IWbemPath::RemoveScope</b> method removes a scope based on the index.
    ///Params:
    ///    uIndex = Index of the scope to be removed.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> with one of the following values.
    ///    
    HRESULT RemoveScope(uint uIndex);
    ///The <b>IWbemPath::RemoveAllScopes</b> method removes all scopes from the path.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> with one of the values in the following.
    ///    
    HRESULT RemoveAllScopes();
    ///The <b>IWbemPath::SetClassName</b> method sets the class name portion of the path.
    ///Params:
    ///    Name = Class name.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call.
    ///    
    HRESULT SetClassName(const(PWSTR) Name);
    HRESULT GetClassNameA(uint* puBuffLength, PWSTR pszName);
    ///The <b>IWbemPath::GetKeyList</b> method retrieves an IWbemPathKeyList pointer so that the individual key may be
    ///accessed.
    ///Params:
    ///    pOut = Pointer to an IWbemPathKeyList object.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call.
    ///    
    HRESULT GetKeyList(IWbemPathKeyList* pOut);
    ///The <b>IWbemPath::CreateClassPart</b> method initializes the class or key portion of the path. This method is
    ///used when creating a path from scratch.
    ///Params:
    ///    lFlags = Reserved. Must be 0 (zero).
    ///    Name = Initial class name.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call.
    ///    
    HRESULT CreateClassPart(int lFlags, const(PWSTR) Name);
    ///The <b>IWbemPath::DeleteClassPart</b> method deletes the class portion of the path.
    ///Params:
    ///    lFlags = Reserved. Must be 0 (zero).
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call.
    ///    
    HRESULT DeleteClassPart(int lFlags);
    ///The <b>IWbemPath::IsRelative</b> method tests if the path, as already set in the parser, is relative to a
    ///particular computer and namespace.
    ///Params:
    ///    wszMachine = Name of the computer.
    ///    wszNamespace = Namespace being tested.
    ///Returns:
    ///    This method returns a BOOL indicating whether the path is relative to the specified computer and namespace.
    ///    
    BOOL    IsRelative(PWSTR wszMachine, PWSTR wszNamespace);
    ///The <b>IWbemPath::IsRelativeOrChild</b> method tests if the path, as already set in the parser, is relative to or
    ///a child of a particular computer and namespace.
    ///Params:
    ///    wszMachine = Name of the computer.
    ///    wszNamespace = Namespace being tested.
    ///    lFlags = Reserved. Must be 0 (zero).
    ///Returns:
    ///    This method returns a <b>BOOL</b> indicating whether the path is relative to the specified computer and
    ///    namespace.
    ///    
    BOOL    IsRelativeOrChild(PWSTR wszMachine, PWSTR wszNamespace, int lFlags);
    ///The <b>IWbemPath::IsLocal</b> method tests if the computer name passed in matches the computer name in the path,
    ///or if the server name in the path is <b>NULL</b> or ".".
    ///Params:
    ///    wszMachine = Name of the computer to test.
    ///Returns:
    ///    This method returns a <b>BOOL</b> indicating whether the path matches the passed in computer name, or if the
    ///    server name in the path is <b>NULL</b> or ".".
    ///    
    BOOL    IsLocal(const(PWSTR) wszMachine);
    ///The <b>IWbemPath::IsSameClassName</b> method tests whether the class name passed in matches the one in the path.
    ///The method can return <b>TRUE</b> only if the path actually has a class name.
    ///Params:
    ///    wszClass = Class name to test.
    ///Returns:
    ///    This method returns a BOOL indicating whether the class name matches the one in the path.
    ///    
    BOOL    IsSameClassName(const(PWSTR) wszClass);
}

///The <b>IWbemQuery</b> interface provides an entry point through which a WMI Query Language (WQL) query can be parsed.
///For more information about WQL, see WQL (SQL for WMI). The following table lists the methods for <b>IWbemQuery</b>.
@GUID("81166F58-DD98-11D3-A120-00105A1F515A")
interface IWbemQuery : IUnknown
{
    ///The <b>IWbemQuery::Empty</b> method frees the memory that the parser is holding.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call.
    ///    
    HRESULT Empty();
    HRESULT SetLanguageFeatures(uint uFlags, uint uArraySize, uint* puFeatures);
    HRESULT TestLanguageFeatures(uint uFlags, uint* uArraySize, uint* puFeatures);
    ///The <b>IWbemQuery::Parse</b> method parses a query string.
    ///Params:
    ///    pszLang = Language of the query. Must be either "WQL" or "SQL" (case-sensitive). Any other value will result in the
    ///              method failing and <b>WBEM_E_INVALID_PARAMETER</b> being returned.
    ///    pszQuery = Valid WQL or SQL WMI query.
    ///    uFlags = Reserved for future use. Must be 0 (zero).
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call.
    ///    
    HRESULT Parse(const(PWSTR) pszLang, const(PWSTR) pszQuery, uint uFlags);
    ///The <b>IWbemQuery::GetAnalysis</b> method gets the results of a successful query parse.
    ///Params:
    ///    uAnalysisType = Type of analysis to get.
    ///    uFlags = Reserved for future use.
    ///    pAnalysis = Pointer to the analysis generated by a call to <b>IWbemQuery::GetAnalysis</b>. It is important to free up
    ///                this memory by calling IWbemQuery::FreeMemory.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> that indicates the status of a method call.
    ///    
    HRESULT GetAnalysis(uint uAnalysisType, uint uFlags, void** pAnalysis);
    ///The <b>IWbemQuery::FreeMemory</b> method frees the memory that the parser returns to a caller in a previous call
    ///to GetAnalysis.
    ///Params:
    ///    pMem = Pointer to the memory to be freed.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call.
    ///    
    HRESULT FreeMemory(void* pMem);
    HRESULT GetQueryInfo(uint uAnalysisType, uint uInfoId, uint uBufSize, void* pDestBuf);
}

///The <b>IWbemClassObject</b> interface contains and manipulates both class definitions and class object instances.
@GUID("DC12A681-737F-11CF-884D-00AA004B2E24")
interface IWbemClassObject : IUnknown
{
    ///The <b>IWbemClassObject::GetQualifierSet</b> method returns an interface pointer that allows read and write
    ///operations on the set of qualifiers for the entire class object, whether the object is an instance or a class
    ///definition. Any qualifiers added, deleted, or edited using the returned pointer apply to the entire instance or
    ///class definition.
    ///Params:
    ///    ppQualSet = Receives the interface pointer that allows access to the qualifiers for the class object. The returned object
    ///                has a positive reference count upon return from the call. The caller must call
    ///                <b>IWbemQualifierSet::Release</b> when the object is no longer needed. This parameter cannot be <b>NULL</b>.
    ///                On error, a new object is not returned and the pointer is left unmodified.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained within an <b>HRESULT</b>. For general <b>HRESULT</b> values, see System Error Codes.
    ///    
    HRESULT GetQualifierSet(IWbemQualifierSet* ppQualSet);
    ///The <b>IWbemClassObject::Get</b> method retrieves the specified property value, if it exists. This method can
    ///also return system properties.
    ///Params:
    ///    wszName = Name of the desired property. It is treated as read-only.
    ///    lFlags = Reserved. This parameter must be 0 (zero).
    ///    pVal = When successful, this parameter is assigned the correct type and value for the qualifier, and the VariantInit
    ///           function is called on <i>pVal</i>. It is the responsibility of the caller to call VariantClear on <i>pVal</i>
    ///           when the value is not needed. If there is an error, the value that <i>pVal</i> points to is not modified. If
    ///           an uninitialized <i>pVal</i> value is passed to the method, then the caller must check the return value of
    ///           the method, and call <b>VariantClear</b> only when the method succeeds.
    ///    pType = Can be <b>NULL</b>. If it is not <b>NULL</b>, it receives the CIM type of the property, that is, one of the
    ///            CIM-type constants, such as <b>CIM_SINT32</b>, <b>CIM_STRING</b>, and so on. For more information about these
    ///            values, see CIMTYPE_ENUMERATION. This indicates the CIM semantics of the property value packed into
    ///            <b>VARIANT</b>.
    ///    plFlavor = Can be <b>NULL</b>. If not <b>NULL</b>, the LONG value pointed to receives information about the origin of
    ///               the property. For more information, see Qualifier Flavors and WBEM_FLAVOR_TYPE.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> that indicates the status of the method call. The following list lists
    ///    the value contained in an <b>HRESULT</b>. For general <b>HRESULT</b> values, see System Error Codes.
    ///    
    HRESULT Get(const(PWSTR) wszName, int lFlags, VARIANT* pVal, int* pType, int* plFlavor);
    ///The <b>IWbemClassObject::Put</b> method sets a named property to a new value. This method always overwrites the
    ///current value with a new one. When IWbemClassObject points to a CIM class definition, <b>Put</b> creates or
    ///updates the property value. When <b>IWbemClassObject</b> points to a CIM instance, <b>Put</b> updates a property
    ///value only. <b>Put</b> cannot create a property value. A user cannot create properties with names that begin or
    ///end with an underscore (_). This is reserved for system classes and properties.
    ///Params:
    ///    wszName = A parameter that must point to a valid property name. This parameter cannot be <b>NULL</b>.
    ///    lFlags = Reserved. This parameter must be 0 (zero).
    ///    pVal = A parameter that must point to a valid <b>VARIANT</b>, which becomes the new property value. If <i>pVal</i>
    ///           is <b>NULL</b> or points to a <b>VARIANT</b> of type <b>VT_NULL</b>, the property is set to <b>NULL</b>, that
    ///           is, no value.
    ///    Type = A type of <b>VARIANT</b> pointed to by <i>pVal</i>. The <b>NULL</b> value for a property designated by a
    ///           <b>VARIANT</b> of type <b>VT_NULL</b> is distinguished from a property of type <b>VT_I4</b> with a 0 (zero)
    ///           value. When creating new properties, if <i>pVal</i> is <b>NULL</b> or points to a <b>VT_NULL</b>, the type of
    ///           the property is determined from the <i>vtType</i> parameter. If <i>pVal</i> is to contain an embedded
    ///           IWbemClassObject, the caller must call <b>IWbemClassObject::QueryInterface</b> for <b>IID_IUnknown</b> and
    ///           place the resulting pointer in the <b>VARIANT</b> using a type of <b>VT_UNKNOWN</b>. The original embedded
    ///           object is copied during the <b>Put</b> operation, and so cannot be modified by the operation. The pointer is
    ///           treated as read-only. The caller must call VariantClear after this call is complete. Use this parameter only
    ///           when creating new properties in a CIM class definition and <i>pVal</i> is <b>NULL</b> or points to a
    ///           <b>VARIANT</b> of type <b>VT_NULL</b>. In such a case, the <i>vtType</i> parameter specifies the CIM type of
    ///           the property. In every other case, <i>vtType</i> must be 0 (zero). Also, <i>vtType</i> must be 0 (zero) when
    ///           the underlying object is an instance (even if <i>pVal</i> is <b>NULL</b>), because the type of the property
    ///           is fixed and cannot be changed. In other words, use <i>vtType</i> if, and only if, <i>pVal</i> is <b>NULL</b>
    ///           or points to a <b>VT_NULL</b><b>VARIANT</b>, and the underlying object is a CIM class. When using
    ///           <b>IWbemClassObject::Put</b> to assign empty array values to a property, you do not need to specify the exact
    ///           VT type; you can assign a value to <i>pVal</i> that is a <b>VARIANT</b> with a variant type of
    ///           <b>VT_ARRAY</b>|<b>VT_VARIANT</b>.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> that indicates the status of the method call. The following list lists
    ///    the values contained within an <b>HRESULT</b>. For general <b>HRESULT</b> values, see System Error Codes.
    ///    
    HRESULT Put(const(PWSTR) wszName, int lFlags, VARIANT* pVal, int Type);
    ///The <b>IWbemClassObject::Delete</b> method deletes the specified property from a CIM class definition and all of
    ///its qualifiers. Because instances cannot have contents that are different from the owning class, delete
    ///operations for properties are only possible on class definitions. If you invoke <b>Delete</b> on a property in an
    ///instance, the operation succeeds; however, rather than removing the value, it is simply reset to the default
    ///value for the class. It is not possible to delete a property inherited from a parent class. However, if an
    ///override default value for a property inherited from a parent class was specified, it is possible to revert to
    ///the parent's default value by invoking this method. In this case, <b>WBEM_S_RESET_TO_DEFAULT</b> is returned.
    ///System properties cannot be deleted.
    ///Params:
    ///    wszName = Property name to delete. This must point to a valid <b>LPCWSTR</b>. It is treated as read-only.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained within an <b>HRESULT</b>. For general <b>HRESULT</b> values, see System Error Codes.
    ///    
    HRESULT Delete(const(PWSTR) wszName);
    ///The <b>IWbemClassObject::GetNames</b> method retrieves the names of the properties in the object. Furthermore,
    ///depending on user-supplied selection criteria, it can retrieve all or a subset of the properties. These
    ///properties can then be accessed by using IWbemClassObject::Get for each name. This method can also return system
    ///properties.
    ///Params:
    ///    wszQualifierName = A parameter that can be <b>NULL</b>. If not <b>NULL</b>, it must point to a valid <b>LPCWSTR</b> specifying a
    ///                       qualifier name which operates as part of a filter. This is handled as read-only. For more information, see
    ///                       Remarks.
    ///    lFlags = For more information, see Remarks.
    ///    pQualifierVal = A parameter that can be <b>NULL</b>. If not <b>NULL</b>, it must point to a valid <b>VARIANT</b> structure
    ///                    initialized to a filter value. This <b>VARIANT</b> is handled as read-only by the method. Thus, the caller
    ///                    must call <b>VariantClear</b> on it, if required. For more information, see Remarks.
    ///    pNames = A parameter that cannot be <b>NULL</b>, but on entry this parameter must point to <b>NULL</b>. A new
    ///             <b>SAFEARRAY</b> structure is always allocated, and the pointer is set to point to it. The returned array can
    ///             have 0 elements, but is always allocated when <b>WBEM_S_NO_ERROR</b> returns. On error, a new
    ///             <b>SAFEARRAY</b> structure is not returned.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained within an <b>HRESULT</b>. For general <b>HRESULT</b> values, see System Error Codes.
    ///    
    HRESULT GetNames(const(PWSTR) wszQualifierName, int lFlags, VARIANT* pQualifierVal, SAFEARRAY** pNames);
    ///The <b>IWbemClassObject::BeginEnumeration</b> method resets an enumeration back to the beginning of the
    ///enumeration. The caller must call this method prior to the first call to IWbemClassObject::Next to enumerate all
    ///of the properties on an object. The order in which properties are enumerated is guaranteed to be invariant for a
    ///given instance of IWbemClassObject.
    ///Params:
    ///    lEnumFlags = Combination of flags described in Remarks.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained within an <b>HRESULT</b>. For general <b>HRESULT</b> values, see System Error Codes.
    ///    
    HRESULT BeginEnumeration(int lEnumFlags);
    ///The <b>IWbemClassObject::Next</b> method retrieves the next property in an enumeration that started with
    ///IWbemClassObject::BeginEnumeration. This should be called repeatedly to enumerate all the properties until
    ///<b>WBEM_S_NO_MORE_DATA</b> returns. If the enumeration is to be terminated early, then
    ///IWbemClassObject::EndEnumeration should be called. The order of the properties returned during the enumeration is
    ///not defined.
    ///Params:
    ///    lFlags = Reserved. This parameter must be 0.
    ///    strName = Receives a new <b>BSTR</b> that contains the property name. To prevent memory leaks in the client process,
    ///              the caller must call SysFreeString when the name is no longer required. You can set this parameter to
    ///              <b>NULL</b> if the name is not required.
    ///    pVal = This <b>VARIANT</b> is filled with the value of the property. The method calls VariantInit on this
    ///           <b>VARIANT</b>, so the caller should ensure that the <b>VARIANT</b> is not active prior to the call. The
    ///           caller must use VariantClear when the value is no longer required. You can set this parameter to <b>NULL</b>
    ///           if the value is not required. If an error code is returned, the <b>VARIANT</b> pointed to by <i>pVal</i> is
    ///           left unmodified.
    ///    pType = This parameter can be <b>NULL</b>. If it is not <b>NULL</b>, it must point to a <b>CIMTYPE</b> variable (a
    ///            <b>LONG</b>) into which the type of the property is placed. It is possible that the value of this property
    ///            can be a <b>VT_NULL</b> <b>VARIANT</b>, in which case it is necessary to determine the actual type of the
    ///            property.
    ///    plFlavor = Can be <b>NULL</b>. If not <b>NULL</b>, the <b>LONG</b> value pointed to receives information on the origin
    ///               of the property as follows. For more information, see Qualifier Flavors and WBEM_FLAVOR_TYPE.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> that indicates the status of the method call. The following list lists
    ///    the value contained within an <b>HRESULT</b>. For general <b>HRESULT</b> values, see System Error Codes.
    ///    
    HRESULT Next(int lFlags, BSTR* strName, VARIANT* pVal, int* pType, int* plFlavor);
    ///The <b>IWbemClassObject::EndEnumeration</b> method terminates an enumeration sequence started with
    ///IWbemClassObject::BeginEnumeration. This call is not required, but it is recommended to developers because it
    ///releases resources associated with the enumeration. However, the resources are deallocated automatically when the
    ///next enumeration is started or the object is released.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained within an <b>HRESULT</b>. For general <b>HRESULT</b> values, see System Error Codes.
    ///    
    HRESULT EndEnumeration();
    ///The <b>IWbemClassObject::GetPropertyQualifierSet</b> method gets the qualifier set for a particular property in
    ///the class object. You can use this method with properties that are a member of an instance or a class definition.
    ///Params:
    ///    wszProperty = Property for which the qualifier set is requested. This cannot be <b>NULL</b> and must point to a valid
    ///                  <b>LPCWSTR</b>. The property can be local or propagated from the parent class. Note that system properties
    ///                  have no qualifiers so this method returns the error code <b>WBEM_E_SYSTEM_PROPERTY</b> if you attempt to
    ///                  obtain the IWbemQualifierSet pointer for a system property.
    ///    ppQualSet = Receives an interface pointer that allows access to the qualifiers for the named property. The caller must
    ///                call <b>IWbemQualifierSet::Release</b> on the pointer when access to the object is no longer required. The
    ///                property is set to point to <b>NULL</b> when there are error conditions. A new object is not returned.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained within an <b>HRESULT</b>. For general <b>HRESULT</b> values, see System Error Codes.
    ///    
    HRESULT GetPropertyQualifierSet(const(PWSTR) wszProperty, IWbemQualifierSet* ppQualSet);
    ///The <b>IWbemClassObject::Clone</b> method returns a new object that is a complete clone of the current object.
    ///The new object has a COM reference count of 1.
    ///Params:
    ///    ppCopy = This parameter cannot be <b>NULL</b>. It receives the copy of the current object. You must call
    ///             <b>IWbemClassObject::Release </b>on this object when it is no longer required. A new object is not returned
    ///             on error.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained within an <b>HRESULT</b>. For general <b>HRESULT</b> values, see System Error Codes.
    ///    
    HRESULT Clone(IWbemClassObject* ppCopy);
    ///The <b>IWbemClassObject::GetObjectText</b> method returns a textual rendering of the object in the MOF syntax.
    ///Notice that the MOF text returned does not contain all the information about the object, but only enough
    ///information for the MOF compiler to be able to re-create the original object. For instance, no propagated
    ///qualifiers or parent class properties are displayed.
    ///Params:
    ///    lFlags = Normally 0. If <b>WBEM_FLAG_NO_FLAVORS</b> is specified, qualifiers will be presented without propagation or
    ///             flavor information.
    ///    pstrObjectText = This must point to <b>NULL</b> on entry. This parameter receives from Windows Management a newly allocated
    ///                     <b>BSTR</b> that was initialized with <b>SysAllocString</b>. You must call <b>SysFreeString</b> on the
    ///                     pointer when the string is no longer required. This pointer points to a MOF syntax rendering of the object
    ///                     upon return from the call. Because this is an out parameter, the pointer must not point to a string that is
    ///                     valid before this method is called, because the pointer will not be deallocated.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained within an <b>HRESULT</b>. For general <b>HRESULT</b> values, see System Error Codes.
    ///    
    HRESULT GetObjectText(int lFlags, BSTR* pstrObjectText);
    ///Use the <b>IWbemClassObject::SpawnDerivedClass</b> method to create a newly derived class object from the current
    ///object. The current object must be a class definition that becomes the parent class of the spawned object. The
    ///returned object becomes a subclass of the current object.
    ///Params:
    ///    lFlags = Reserved. This parameter must be 0.
    ///    ppNewClass = Cannot be <b>NULL</b>. This receives the pointer to the new class definition object. The caller must invoke
    ///                 <b>IWbemClassObject::Release</b> when the object is no longer required, typically after you have invoked
    ///                 IWbemServices::PutClass to write the class definition. On error, a new object is not returned, and
    ///                 <i>ppNewClass</i> is left unmodified.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained within an <b>HRESULT</b>. For general <b>HRESULT</b> values, see System Error Codes.
    ///    
    HRESULT SpawnDerivedClass(int lFlags, IWbemClassObject* ppNewClass);
    ///Use the <b>IWbemClassObject::SpawnInstance</b> method to create a new instance of a class. The current object
    ///must be a class definition obtained from Windows Management using IWbemServices::GetObject,
    ///IWbemServices::CreateClassEnum, or IWbemServices::CreateClassEnumAsync Then, use this class definition to create
    ///new instances. A call to IWbemServices::PutInstance is required to actually write the instance to Windows
    ///Management. If you intend to discard the object before calling <b>IWbemServices::PutInstance</b>, simply make a
    ///call to <b>IWbemClassObject::Release</b>. Note that spawning an instance from an instance is supported but the
    ///returned instance will be empty.
    ///Params:
    ///    lFlags = Reserved. This parameter must be 0.
    ///    ppNewInstance = Cannot be <b>NULL</b>. It receives a new instance of the class. The caller must invoke
    ///                    <b>IWbemClassObject::Release</b> when the pointer is no longer required. On error, a new object is not
    ///                    returned and the pointer is left unmodified.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained within an <b>HRESULT</b>. For general <b>HRESULT</b> values, see System Error Codes.
    ///    
    HRESULT SpawnInstance(int lFlags, IWbemClassObject* ppNewInstance);
    ///The <b>IWbemClassObject::CompareTo</b> method compares an object to another Windows Management object. Note that
    ///there are certain constraints in this comparison process.
    ///Params:
    ///    lFlags = Specifies the object characteristics to consider in comparison to another object. It can be
    ///             <b>WBEM_COMPARISON_INCLUDE_ALL</b> to consider all features, or any combination of these flags.
    ///    pCompareTo = Object in comparison. This pointer must point to a valid IWbemClassObject instance. It cannot be <b>NULL</b>.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained within an <b>HRESULT</b>. For general <b>HRESULT</b> values, see System Error Codes.
    ///    
    HRESULT CompareTo(int lFlags, IWbemClassObject pCompareTo);
    ///The <b>IWbemClassObject::GetPropertyOrigin</b> method retrieves the name of the class in which a particular
    ///property was introduced. For classes with deep inheritance hierarchies, it is often desirable to know which
    ///properties were declared in which classes. If the object does not inherit from a parent class, as in the case of
    ///a base class, for example, then the current class name is returned.
    ///Params:
    ///    wszName = Property name for which the owning class name is desired. This must point to a valid <b>LPCWSTR</b>, which is
    ///              treated as read-only.
    ///    pstrClassName = Pointer to the address of a new <b>BSTR</b> that receives the parent class name. To prevent memory leaks in
    ///                    the client process, the caller must call SysFreeString when the name is no longer required. This parameter
    ///                    must not point to a valid string before the method is called because this is an output parameter, and this
    ///                    pointer is not deallocated after the call is complete.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained within an <b>HRESULT</b>. For general <b>HRESULT</b> values, see System Error Codes.
    ///    
    HRESULT GetPropertyOrigin(const(PWSTR) wszName, BSTR* pstrClassName);
    ///The <b>IWbemClassObject::InheritsFrom</b> method determines if the current class or instance derives from a
    ///specified parent class.
    ///Params:
    ///    strAncestor = Cannot be <b>NULL</b>. It contains the class name that is being tested. If the current object has this class
    ///                  for one of its ancestor classes, <b>WBEM_S_NO_ERROR</b> returns. This must point to a valid <b>LPCWSTR</b>,
    ///                  which is treated as read-only.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained within an <b>HRESULT</b>. For general <b>HRESULT</b> values, see System Error Codes.
    ///    
    HRESULT InheritsFrom(const(PWSTR) strAncestor);
    ///The <b>IWbemClassObject::GetMethod</b> method returns information about the requested method. This call is only
    ///supported if the current object is a CIM class definition. Method information is not available from
    ///IWbemClassObject pointers which point to CIM instances.
    ///Params:
    ///    wszName = The method name. This cannot be <b>NULL</b>, and must point to a valid <b>LPCWSTR</b>.
    ///    lFlags = Reserved. This parameter must be 0.
    ///    ppInSignature = A pointer that receives an IWbemClassObject pointer which describes the in parameters to the method. This
    ///                    parameter is ignored if set to <b>NULL</b>. Be aware that Windows Management can set the
    ///                    <b>IWbemClassObject</b> pointer to <b>NULL</b> if this method has no in parameters. For more information, see
    ///                    Remarks.
    ///    ppOutSignature = A pointer that receives an IWbemClassObject pointer which describes the out-parameters to the method. This
    ///                     parameter will be ignored if set to <b>NULL</b>.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> that indicates the status of the method call. The following list lists
    ///    the value contained within an <b>HRESULT</b>. For general <b>HRESULT</b> values, see System Error Codes.
    ///    
    HRESULT GetMethod(const(PWSTR) wszName, int lFlags, IWbemClassObject* ppInSignature, 
                      IWbemClassObject* ppOutSignature);
    ///The <b>IWbemClassObject::PutMethod</b> is used to create a method. This call is only supported if the current
    ///object is a CIM class definition. Method manipulation is not available from IWbemClassObject pointers that point
    ///to CIM instances. The user cannot create methods with names that begin or end with an underscore. This is
    ///reserved for system classes and properties.
    ///Params:
    ///    wszName = The method name that is created.
    ///    lFlags = Reserved. This parameter must be 0 (zero).
    ///    pInSignature = A pointer to a copy of the __Parameters system class that contains the in parameters for the method. This
    ///                   parameter is ignored if set to <b>NULL</b>.
    ///    pOutSignature = A pointer to a copy of the __Parameters system class that contains the out parameters for the object. This
    ///                    parameter is ignored if set to <b>NULL</b>.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> that indicates the status of the method call. The following list lists
    ///    the value contained within an <b>HRESULT</b>. For general <b>HRESULT</b> values, see System Error Codes.
    ///    
    HRESULT PutMethod(const(PWSTR) wszName, int lFlags, IWbemClassObject pInSignature, 
                      IWbemClassObject pOutSignature);
    ///Use the <b>IWbemClassObject::DeleteMethod</b> method to delete a method. This call is supported only if the
    ///current object is a CIM class definition. Method manipulation is not available from IWbemClassObject pointers
    ///which point to CIM instances.
    ///Params:
    ///    wszName = Method name to be removed from the class definition.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained within an <b>HRESULT</b>. For general <b>HRESULT</b> values, see System Error Codes.
    ///    
    HRESULT DeleteMethod(const(PWSTR) wszName);
    ///Use the <b>IWbemClassObject::BeginMethodEnumeration</b> method call to begin an enumeration of the methods
    ///available for the object. This call is only supported if the current object is a CIM class definition. Method
    ///manipulation is not available from IWbemClassObject pointers which point to CIM instances. The order in which
    ///methods are enumerated is guaranteed to be invariant for a given instance of <b>IWbemClassObject</b>.
    ///Params:
    ///    lEnumFlags = Specifies the scope of the enumeration. Possible values:
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained within an <b>HRESULT</b>. For general <b>HRESULT</b> values, see System Error Codes.
    ///    
    HRESULT BeginMethodEnumeration(int lEnumFlags);
    ///The <b>IWbemClassObject::NextMethod</b> method is used to retrieve the next method in a method enumeration
    ///sequence that starts with a call to IWbemClassObject::BeginMethodEnumeration. This call is only supported if the
    ///current object is a CIM class definition. Method manipulation is not available from IWbemClassObject pointers
    ///that point to CIM instances.
    ///Params:
    ///    lFlags = Reserved. This parameter must be 0 (zero).
    ///    pstrName = A pointer that should point to <b>NULL</b> prior to the call. This parameter receives the address of a
    ///               <b>BSTR</b> value containing the method name. The caller must release the string using <b>SysFreeString</b>
    ///               when it is no longer required.
    ///    ppInSignature = A pointer that receives a pointer to an IWbemClassObject containing the in parameters for the method.
    ///    ppOutSignature = A pointer that receives a pointer to an IWbemClassObject containing the out parameters for the method.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained within an <b>HRESULT</b>. For general <b>HRESULT</b> values, see System Error Codes.
    ///    
    HRESULT NextMethod(int lFlags, BSTR* pstrName, IWbemClassObject* ppInSignature, 
                       IWbemClassObject* ppOutSignature);
    ///The <b>IWbemClassObject::EndMethodEnumeration</b> method is used to terminate a method enumeration sequence
    ///started with IWbemClassObject::BeginMethodEnumeration. This call is only supported if the current object is a CIM
    ///class definition. Method manipulation is not available from IWbemClassObject pointers which point to CIM
    ///instances.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained within an <b>HRESULT</b>. For general <b>HRESULT</b> values, see System Error Codes.
    ///    
    HRESULT EndMethodEnumeration();
    ///The <b>IWbemClassObject::GetMethodQualifierSet</b> is used to retrieve the qualifier set for a particular method.
    ///This call is supported only if the current object is a CIM class definition. Method manipulation is not available
    ///from IWbemClassObject pointers, which point to CIM instances.
    ///Params:
    ///    wszMethod = Must point to a valid <b>LPCWSTR</b> containing the method name.
    ///    ppQualSet = Receives the interface pointer that allows access to the qualifiers for the method. The returned object has a
    ///                positive reference count upon return from the call. The caller must call <b>IWbemQualifierSet::Release</b>
    ///                when the object is no longer needed. This parameter cannot be <b>NULL</b>. On error, a new object is not
    ///                returned, and the pointer is set to point to <b>NULL</b>.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained within an <b>HRESULT</b>. For general <b>HRESULT</b> values, see System Error Codes.
    ///    
    HRESULT GetMethodQualifierSet(const(PWSTR) wszMethod, IWbemQualifierSet* ppQualSet);
    ///The <b>IWbemClassObject::GetMethodOrigin</b> method is used to determine the class for which a method was
    ///declared. This call is only supported if the current object is a CIM class definition. Method manipulation is not
    ///available from IWbemClassObject pointers which point to CIM instances.
    ///Params:
    ///    wszMethodName = Name of the method for the object whose owning class is being requested.
    ///    pstrClassName = Receives the name of the class which owns the method. The user must call <b>SysFreeString </b>on the returned
    ///                    <i>BSTR</i> when it is no longer required.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained within an <b>HRESULT</b>. For general <b>HRESULT</b> values, see System Error Codes.
    ///    
    HRESULT GetMethodOrigin(const(PWSTR) wszMethodName, BSTR* pstrClassName);
}

///The <b>IWbemObjectAccess</b> interface provides access to the methods and properties of an object. An
///<b>IWbemObjectAccess</b> object is a container for an instance updated by a refresher. With the
///<b>IWbemObjectAccess</b> interface, you can get and set properties by using property handles instead of object
///property names. <div class="alert"><b>Note</b> This interface is not implemented by client applications or providers
///under any circumstances. The implementation provided by WMI is the only one that is supported. A pointer to the
///interface can be retrieved by calling IWbemClassObject::QueryInterface.</div><div> </div>
@GUID("49353C9A-516B-11D1-AEA6-00C04FB68820")
interface IWbemObjectAccess : IWbemClassObject
{
    ///The <b>GetPropertyHandle</b> method returns a unique handle that identifies a property. You can use this handle
    ///to identify properties when using IWbemObjectAccess methods to read or write property values.
    ///Params:
    ///    wszPropertyName = Constant, null-terminated string of 16-bit Unicode characters that contains the property name.
    ///    pType = Pointer to a <b>CIMTYPE</b> used to return the CIM type of the property.
    ///    plHandle = Pointer to an integer used to return the property handle.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained withinan <b>HRESULT</b>.
    ///    
    HRESULT GetPropertyHandle(const(PWSTR) wszPropertyName, int* pType, int* plHandle);
    ///The <b>WritePropertyValue</b> method writes a specified number of bytes to a property identified by a property
    ///handle. Use this method to set string and all other non-<b>DWORD</b> or non-<b>QWORD</b> data.
    ///Params:
    ///    lHandle = Integer that contains the handle that identifies this property.
    ///    lNumBytes = Integer that contains the number of bytes being written to the property. For nonstring property values,
    ///                <i>lNumBytes</i> must be the correct data size of the property type specified. For string property values
    ///                such as reference, string, and datetime, <i>lNumBytes</i> must be the length of the specified string in
    ///                bytes, and the string itself must be of an even length in bytes and be followed with a null-termination
    ///                character.
    ///    aData = Pointer to the constant byte type array that contains the data.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained withinan <b>HRESULT</b>.
    ///    
    HRESULT WritePropertyValue(int lHandle, int lNumBytes, const(ubyte)* aData);
    ///The <b>ReadPropertyValue</b> method returns a specified number of bytes of a property associated with a property
    ///handle. Use this method to read the value of a property that contains a string or to read a property that
    ///contains a value that is not 32 (<b>DWORD</b>) or 64 (<b>QWORD</b>) bits long.
    ///Params:
    ///    lHandle = Integer that contains the handle identifying this property.
    ///    lBufferSize = Integer that contains the buffer size.
    ///    plNumBytes = Pointer to an integer used to return the number of bytes read.
    ///    aData = Pointer to an array used to return the property data.
    ///Returns:
    ///    This method returns <b>WBEM_S_NO_ERROR</b> if successful; otherwise, this method returns an <b>HRESULT</b>
    ///    with one of the following values.
    ///    
    HRESULT ReadPropertyValue(int lHandle, int lBufferSize, int* plNumBytes, ubyte* aData);
    ///The <b>ReadDWORD</b> method reads 32 bits of property data using a property handle.
    ///Params:
    ///    lHandle = Integer that contains the handle that identifies this property.
    ///    pdw = Pointer to a 32-bit unsigned integer used to return the data.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> that indicates the status of the method call. The following list lists
    ///    the value contained withinan <b>HRESULT</b>.
    ///    
    HRESULT ReadDWORD(int lHandle, uint* pdw);
    ///The <b>WriteDWORD</b> method writes 32 bits of data to a property identified by a property handle.
    ///Params:
    ///    lHandle = Integer that contains the handle identifying this property.
    ///    dw = Unsigned 32-bit integer that contains the data being written.
    ///Returns:
    ///    This method returns <b>WBEM_S_NO_ERROR</b> if successful.
    ///    
    HRESULT WriteDWORD(int lHandle, uint dw);
    ///The <b>ReadQWORD</b> method reads 64 bits of property data identified by a property handle.
    ///Params:
    ///    lHandle = Integer that contains the handle identifying the property.
    ///    pqw = Pointer to a unsigned 64-bit integer used to return the data being read.
    ///Returns:
    ///    This method returns <b>WBEM_S_NO_ERROR</b> if successful. If the property was <b>NULL</b>, then the method
    ///    returns <b>WBEM_S_FALSE</b>.
    ///    
    HRESULT ReadQWORD(int lHandle, ulong* pqw);
    ///The <b>WriteQWORD</b> method writes 64 bits of data to a property by using a property handle.
    ///Params:
    ///    lHandle = Integer that contains the handle that identifies this property.
    ///    pw = Unsigned 64-bit integer that contains the data written to the specified property.
    ///Returns:
    ///    This method returns <b>WBEM_S_NO_ERROR</b> if successful.
    ///    
    HRESULT WriteQWORD(int lHandle, ulong pw);
    ///The <b>GetPropertyInfoByHandle</b> method returns the name and data type of the property that is associated with
    ///a property handle.
    ///Params:
    ///    lHandle = Integer that contains the handle identifying the property.
    ///    pstrName = Pointer to a string used to return the name of the specified property.
    ///    pType = Pointer to a <b>CIMTYPE</b> used to return the type of the property.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained withinan <b>HRESULT</b>.
    ///    
    HRESULT GetPropertyInfoByHandle(int lHandle, BSTR* pstrName, int* pType);
    ///The <b>Lock</b> method prevents other threads from updating an IWbemObjectAccess object until it is unlocked.
    ///Params:
    ///    lFlags = Reserved. This parameter is currently ignored and is reserved for future use.
    ///Returns:
    ///    This method returns <b>WBEM_S_NO_ERROR</b> if successful.
    ///    
    HRESULT Lock(int lFlags);
    ///The <b>Unlock</b> method allows other threads to update the property values of an IWbemObjectAccess object.
    ///Params:
    ///    lFlags = Reserved. This parameter is currently ignored and is reserved for future use.
    ///Returns:
    ///    This method returns <b>WBEM_S_NO_ERROR</b> if successful.
    ///    
    HRESULT Unlock(int lFlags);
}

///The <b>IWbemQualifierSet</b> interface acts as a container for the entire set of named qualifiers for a single
///property or entire object (a class or instance). The contents of the container depend on how the pointer was
///obtained. If the pointer was obtained from IWbemClassObject::GetQualifierSet, the object consists of the set of
///qualifiers for an entire object. If the pointer was obtained from IWbemClassObject::GetPropertyQualifierSet, then the
///object represents the qualifiers for a particular property.
@GUID("DC12A680-737F-11CF-884D-00AA004B2E24")
interface IWbemQualifierSet : IUnknown
{
    ///The <b>IWbemQualifierSet::Get</b> method gets the specified named qualifier, if found.
    ///Params:
    ///    wszName = Name of the qualifier for which the value is being requested. The pointer is treated as read-only.
    ///    lFlags = Reserved. This parameter must be 0.
    ///    pVal = When successful, <b>VARIANT</b> is assigned to the correct type and value for the qualifier.
    ///           <b>VariantInit</b> is called on this <b>VARIANT</b>. It is the responsibility of the caller to call
    ///           <b>VariantClear</b> on the pointer when the value is no longer required. If there is an error code, the
    ///           <b>VARIANT</b> pointed to by <i>pVal</i> is not modified. If this parameter is <b>NULL</b>, the parameter is
    ///           ignored.
    ///    plFlavor = Can be <b>NULL</b>. If not <b>NULL</b>, this must point to a <b>LONG</b> that receives the qualifier flavor
    ///               bits for the requested qualifier. For more information, see Qualifier Flavors and WBEM_FLAVOR_TYPE.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained within an <b>HRESULT</b>.
    ///    
    HRESULT Get(const(PWSTR) wszName, int lFlags, VARIANT* pVal, int* plFlavor);
    ///The <b>IWbemQualifierSet::Put</b> method writes the named qualifier and value. The new qualifier overwrites the
    ///previous value of the same name. If the qualifier does not exist, it is created. Sometimes it is not possible to
    ///write the value of a qualifier, for example, if the qualifier is propagated from another object. Typically,
    ///propagated qualifiers are read-only, but they can be overridden. For more information, see Qualifier Flavors.
    ///When using the Key qualifier, it is not necessary to specify any flavors or propagation rules. The user may not
    ///create qualifiers with names that begin or end with an underscore (_). This is reserved for system classes and
    ///properties.
    ///Params:
    ///    wszName = Name of the qualifier that is being written. The pointer is treated as read-only.
    ///    pVal = Cannot be <b>NULL</b>. This must point to a valid <b>VARIANT</b> that contains the qualifier value to be
    ///           written. The pointer is treated as read-only. It is the caller's responsibility to call VariantClear on this
    ///           pointer after the value is not required. Only variants and arrays of type <b>VT_I4</b>, <b>VT_R8</b>,
    ///           <b>VT_BSTR</b>, <b>VT_BOOL</b> are supported.
    ///    lFlavor = Desired qualifier flavors for this qualifier. The following list lists the appropriate constants for
    ///              <i>lFlavor</i>. The default value is zero (0).
    ///Returns:
    ///    This method returns an <b>HRESULT</b> that indicates the status of the method call. The following list lists
    ///    the value contained withinan <b>HRESULT</b>.
    ///    
    HRESULT Put(const(PWSTR) wszName, VARIANT* pVal, int lFlavor);
    ///The <b>IWbemQualifierSet::Delete</b> method deletes the specified qualifier by name. Due to qualifier propagation
    ///rules, a particular qualifier may have been inherited from another object and merely overridden in the current
    ///class or instance. In this case, use the <b>Delete</b> method to reset the qualifier to the original inherited
    ///value.
    ///Params:
    ///    wszName = Name of the qualifier to delete. The pointer is treated as read-only.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained withinan <b>HRESULT</b>.
    ///    
    HRESULT Delete(const(PWSTR) wszName);
    ///The <b>IWbemQualifierSet::GetNames</b> method retrieves the names of all of the qualifiers available from the
    ///current object or property. Alternately, depending on the filter value of <i>IFlags</i>, this method retrieves
    ///the names of certain qualifiers. You can access these qualifiers by name, using IWbemQualifierSet::Get for each
    ///name. It is not an error for any given object to have zero qualifiers, so the number of strings in
    ///<i>pstrNames</i> on return can be 0, even though <b>WBEM_S_NO_ERROR</b> returns.
    ///Params:
    ///    lFlags = One of the following constants.
    ///    pNames = A new <b>SAFEARRAY</b> is created that contains the requested names. In all cases where no error is returned,
    ///             a new array is created and <i>pstrNames</i> is set to point to it. This occurs even though the resulting
    ///             array has zero elements. On error, a new <b>SAFEARRAY</b> is not returned.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained withinan <b>HRESULT</b>.
    ///    
    HRESULT GetNames(int lFlags, SAFEARRAY** pNames);
    ///The <b>IWbemQualifierSet::BeginEnumeration</b> method resets before there is an enumeration of all the qualifiers
    ///in the object. To enumerate all of the qualifiers on an object, this method must be called before the first call
    ///to IWbemQualifierSet::Next. The order in which qualifiers are enumerated is guaranteed to be invariant for a
    ///given instance of IWbemQualifierSet.
    ///Params:
    ///    lFlags = Specifies the qualifiers to include in the enumeration. It must be one of the following constants.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained withinan <b>HRESULT</b>.
    ///    
    HRESULT BeginEnumeration(int lFlags);
    ///The <b>IWbemQualifierSet::Next</b> method retrieves the next qualifier in an enumeration that started with
    ///IWbemQualifierSet::BeginEnumeration. This method is called repeatedly to enumerate all the qualifiers until
    ///<b>WBEM_S_NO_MORE_DATA</b> returns. To terminate the enumeration early, call IWbemQualifierSet::EndEnumeration.
    ///The order of the qualifiers returned during the enumeration is not defined.
    ///Params:
    ///    lFlags = Reserved. This parameter must be 0 (zero).
    ///    pstrName = This parameter receives the name of the qualifier. A new <b>BSTR</b> is always allocated whenever
    ///               <b>WBEM_S_NO_ERROR</b> returns. If <i>pstrName</i> is <b>NULL</b>, it is ignored; otherwise, the caller must
    ///               ensure that this parameter does not point to a valid <b>BSTR</b> on entry, or else there will be a memory
    ///               leak. Also, the caller must remember to call <b>SysFreeString</b> on the returned string when it is no longer
    ///               required.
    ///    pVal = This parameter receives the value for the qualifier. <b>VariantInit</b> is called on the <b>VARIANT</b> by
    ///           this method. The caller must call <b>VariantClear</b> on this pointer when the value is no longer required.
    ///           If an error code is returned, the <b>VARIANT</b> pointed to by <i>pVal</i> is left unmodified. This parameter
    ///           is ignored if set to <b>NULL</b>.
    ///    plFlavor = If not <b>NULL</b>, the value pointed to is set to the qualifier flavor. For more information, see Qualifier
    ///               Flavors and WBEM_FLAVOR_TYPE.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained within an <b>HRESULT</b>.
    ///    
    HRESULT Next(int lFlags, BSTR* pstrName, VARIANT* pVal, int* plFlavor);
    ///Call the <b>IWbemQualifierSet::EndEnumeration</b> method when you plan to terminate enumerations initiated with
    ///IWbemQualifierSet::BeginEnumeration and IWbemQualifierSet::Next. This call is recommended, but not required. It
    ///immediately releases resources associated with the enumeration.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained withinan <b>HRESULT</b>.
    ///    
    HRESULT EndEnumeration();
}

///The <b>IWbemServices</b> interface is used by clients and providers to access WMI services. The interface is
///implemented by WMI and WMI providers, and is the primary WMI interface. ```cpp IWbemClassObject *pObj = NULL; //The
///pWbemSvc pointer is of type IWbemServices* pWbemSvc->GetObject(L"path", 0, 0, &pObj, 0); ```
@GUID("9556DC99-828C-11CF-A37E-00AA003240C7")
interface IWbemServices : IUnknown
{
    ///The <b>IWbemServices::OpenNamespace</b> method provides the caller with a new IWbemServices pointer that has the
    ///specified child namespace as its operating context. All operations through the new pointer, such as class or
    ///instance creation, only affect that namespace. The namespace must be a child namespace of the current object
    ///through which this method is called.
    ///Params:
    ///    strNamespace = Path to the target namespace. For more information, see Creating Hierarchies within WMI. This namespace can
    ///                   only be relative to the current namespace associated with the IWbemServices interface pointer. This parameter
    ///                   cannot be an absolute path or <b>NULL</b>.
    ///    lFlags = This parameter can be set to 0 to make this a synchronous call. To make this a semisynchronous call, set
    ///             <i>lFlags</i> to <b>WBEM_FLAG_RETURN_IMMEDIATELY</b>, provide a valid pointer for the <i>ppResult</i>
    ///             parameter, and this call will return immediately. For more information, see Calling a Method.
    ///    pCtx = Reserved. This parameter must be <b>NULL</b>.
    ///    ppWorkingNamespace = Receives the object that represents the new namespace context. The returned pointer has a positive reference
    ///                         count. The caller must call <b>Release</b> on this pointer when it is no longer needed. This pointer is set
    ///                         to <b>NULL</b> when there are errors. If this parameter is specified, then <i>ppResult</i> must be
    ///                         <b>NULL</b>.
    ///    ppResult = Typically <b>NULL</b>. If not <b>NULL</b>, then <i>ppWorkingNamespace</i> must be <b>NULL</b>. In this case,
    ///               the parameter receives a pointer to a new IWbemCallResult object. If the <i>lFlags</i> parameter is set to
    ///               <b>WBEM_FLAG_RETURN_IMMEDIATELY</b> this call returns immediately. Then the caller can periodically poll the
    ///               IWbemCallResult::GetResultServices method until the pointer for the requested namespace becomes available.
    ///               This parameter is set to point to <b>NULL</b> when there is an error and a new object is not returned. <div
    ///               class="alert"><b>Note</b> It is important to note that when you use this parameter, you must set
    ///               <i>ppResult</i> to point to <b>NULL</b> before calling the method. This is a COM rule.</div> <div> </div>
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained within an <b>HRESULT</b>. On failure, you can obtain any available information from the COM
    ///    function GetErrorInfo. COM-specific error codes may also be returned if network problems cause you to lose
    ///    the remote connection to Windows Management.
    ///    
    HRESULT OpenNamespace(const(BSTR) strNamespace, int lFlags, IWbemContext pCtx, 
                          IWbemServices* ppWorkingNamespace, IWbemCallResult* ppResult);
    ///The <b>IWbemServices::CancelAsyncCall</b> method cancels any currently pending asynchronous calls based on the
    ///IWbemObjectSink pointer, which was originally passed to the asynchronous method. The outstanding
    ///<b>IWbemObjectSink</b> pointer can be released prior to the call or after the call returns. The
    ///<b>CancelAsyncCall</b> method is not operational from within a sink and is not supported by method providers.
    ///This means only the client end of the call is canceled. The implementing provider is not notified that the call
    ///was canceled and runs to completion. You should consider this before canceling methods that take a long time to
    ///complete, such as the Defrag and Format methods in the Win32_Volume class.
    ///Params:
    ///    pSink = Pointer to the IWbemObjectSink implementation provided by the client to any of the asynchronous methods of
    ///            IWbemServices.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> that indicates the status of the method call. The following list lists
    ///    the value contained within an <b>HRESULT</b>. On failure, you can obtain available information from the COM
    ///    function GetErrorInfo. COM-specific error codes can also be returned if network problems cause you to lose
    ///    the remote connection to Windows Management. <div class="alert"><b>Note</b> If SetStatus has not been called
    ///    on the application's sink by the time WMI processes <b>CancelAsyncCall</b>, WMI calls <b>SetStatus</b> on
    ///    that sink with <b>WBEM_E_CALL_CANCELLED</b> as the value for the <i>hResult</i> parameter.</div> <div> </div>
    ///    Timing, and the nature of an asynchronous operation, can affect whether WMI is able to cancel the operation.
    ///    Only lengthy queries are likely to be successfully canceled before they have completed. Faster operations,
    ///    such as asynchronous deletions or modifications, typically complete before WMI can process a
    ///    <b>CancelAsyncCall</b> call. So while <b>CancelAsyncCall</b> attempts to cancel the current operation,
    ///    sometimes all that can be done is to release the IWbemObjectSink pointer. <div class="alert"><b>Note</b> It
    ///    is possible to make numerous asynchronous calls using the same object sink. In this case, the
    ///    <b>CancelAsyncCall</b> method cancels all asynchronous calls sharing this object sink. It is strongly
    ///    recommended that you create one instance of an object sink for each outstanding asynchronous call.</div>
    ///    <div> </div>
    ///    
    HRESULT CancelAsyncCall(IWbemObjectSink pSink);
    ///The <b>IWbemServices::QueryObjectSink</b> method allows the caller to obtain a notification handler that is
    ///exported by Windows Management. This allows the caller to write notifications and events directly to Windows
    ///Management. The caller should only write extrinsic events to Windows Management. For more information, see
    ///Determining the Type of Event to Receive.
    ///Params:
    ///    lFlags = Reserved. This parameter must be 0.
    ///    ppResponseHandler = Receives the interface pointer to the notification handler. This is set to point to <b>NULL</b> when there is
    ///                        an error. The returned pointer has a positive reference count, and the caller must call
    ///                        <b>IWbemServices::Release</b> on the pointer when it is no longer needed. A <b>NULL</b> value can be returned
    ///                        if no notification handler is available. This is not an error. <div class="alert"><b>Note</b> The value of
    ///                        the <i>ppResponseHandler</i> parameter cannot be <b>NULL</b> when it is passed to this method.</div> <div>
    ///                        </div>
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained withinan <b>HRESULT</b>. COM-specific error codes also may be returned if network problems
    ///    cause you to lose the remote connection to Windows Management. <div class="alert"><b>Note</b> Firing events
    ///    using <b>QueryObjectSink</b> is permitted by default for Administrators only. Extending the permission to
    ///    other users requires giving them <b>WBEM_FULL_WRITE</b> permission.</div> <div> </div>
    ///    
    HRESULT QueryObjectSink(int lFlags, IWbemObjectSink* ppResponseHandler);
    HRESULT GetObjectA(const(BSTR) strObjectPath, int lFlags, IWbemContext pCtx, IWbemClassObject* ppObject, 
                       IWbemCallResult* ppCallResult);
    ///The <b>IWbemServices::GetObjectAsync</b> method retrieves an object, either a class definition or instance, based
    ///on its path. This is similar to IWbemServices::GetObject except that the call returns immediately, and the object
    ///is provided to the supplied object sink. Currently, this method retrieves objects only from the namespace
    ///associated with the IWbemServices pointer.
    ///Params:
    ///    strObjectPath = Path of the object to retrieve. For an instance provider, <i>StrObjectPath</i> can be in the following
    ///                    format: <ul> <li>Namespace:Class.Key = "Value"</li> <li>Namespace:Class = "Value"</li>
    ///                    <li>Namespace:Class.Key = "Value", Key2 = "Value2"</li> </ul> Specifying the namespace before the class is
    ///                    optional. Object paths without namespaces refer to instances in the current namespace. If necessary, you can
    ///                    substitute the single-quotation mark character (') for the double-quotation mark character (") to delimit the
    ///                    start and end of string property types. If this is <b>NULL</b>, an empty object, which can become a new
    ///                    class, is returned. For more information, see Creating a Class.
    ///    lFlags = The following flags affect the behavior of this method.
    ///    pCtx = Typically <b>NULL</b>. Otherwise, this is a pointer to an IWbemContext object that can be used by the
    ///           provider that produces the requested class or instance. The values in the context object must be specified in
    ///           the documentation for the provider in question. For more information about this parameter, see Making Calls
    ///           to WMI.
    ///    pResponseHandler = Pointer to the caller's implementation of IWbemObjectSink. This handler receives the requested object when it
    ///                       becomes available through the IWbemObjectSink::Indicate method. The <i>pObjParam</i> parameter contains the
    ///                       object. If any error code is returned, then the supplied <b>IWbemObjectSink</b> pointer is not used. If
    ///                       <b>WBEM_S_NO_ERROR</b> is returned, then the user's <b>IWbemObjectSink</b> implementation is called to
    ///                       indicate the result of the operation. Windows Management only calls AddRef to the pointer in cases where
    ///                       <b>WBEM_S_NO_ERROR</b> returns. In cases where an error code returns, the reference count is the same as on
    ///                       entry. For more information about this parameter, see Calling a Method.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> that indicates the status of the method call. The following list lists
    ///    the value contained within an <b>HRESULT</b>. On failure, you can obtain any available information from the
    ///    COM function GetErrorInfo<b>GetErrorInfo</b>. COM-specific error codes can also be returned if network
    ///    problems cause you to lose the remote connection to Windows Management.
    ///    
    HRESULT GetObjectAsync(const(BSTR) strObjectPath, int lFlags, IWbemContext pCtx, 
                           IWbemObjectSink pResponseHandler);
    ///The <b>IWbemServices::PutClass</b> method creates a new class or updates an existing one. The class specified by
    ///the <i>pObject</i> parameter must have been correctly initialized with all of the required property values. The
    ///user may not create classes with names that begin or end with an underscore (_). This is reserved for system
    ///classes.
    ///Params:
    ///    pObject = Must point to a valid class definition. The reference count is not changed.
    ///    lFlags = The following flags affect the behavior of this method.
    ///    pCtx = Typically <b>NULL</b>. Otherwise, this is a pointer to an IWbemContext object required by the dynamic class
    ///           provider that is producing the class instances. The values in the context object must be specified in the
    ///           documentation for the provider in question. For more information about this parameter, see Making Calls to
    ///           WMI.
    ///    ppCallResult = If <b>NULL</b>, this parameter is not used. If the <i>lFlags</i> parameter contains
    ///                   <b>WBEM_FLAG_RETURN_IMMEDIATELY</b>, this call returns immediately with <b>WBEM_S_NO_ERROR</b>. The
    ///                   <i>ppCallResult</i> parameter receives a pointer to a new IWbemCallResult object, which can then be polled to
    ///                   obtain the result using the IWbemCallResult::GetCallStatus method.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained withinan <b>HRESULT</b>. On failure, you can obtain any available information from the COM
    ///    function GetErrorInfo. COM-specific error codes also may be returned if network problems cause you to lose
    ///    the remote connection to Windows Management. <div class="alert"><b>Note</b> Unpredictable behavior will
    ///    result if you change class definitions while they are in use by clients or providers. The
    ///    <b>IWbemServices::PutClass</b> method should only be used to create or update a class when there are no
    ///    clients or providers currently using the class.</div> <div> </div>
    ///    
    HRESULT PutClass(IWbemClassObject pObject, int lFlags, IWbemContext pCtx, IWbemCallResult* ppCallResult);
    ///The <b>IWbemServices::PutClassAsync</b> method creates a new class, or updates an existing one. The class
    ///specified by the <i>pObject</i> parameter must be correctly initialized with all of the required property values.
    ///The call immediately returns. Success or failure is supplied to the object sink specified by the
    ///<i>pResponseHandler</i> parameter.
    ///Params:
    ///    pObject = Pointer to the object containing the class definition.
    ///    lFlags = One or more of the following values are valid.
    ///    pCtx = Typically <b>NULL</b>. Otherwise, this is a pointer to an IWbemContext object that may be used by the
    ///           provider that is receiving the requested class. The values in the context object must be specified in the
    ///           documentation for the provider in question. For more information about this parameter, see Making Calls to
    ///           WMI.
    ///    pResponseHandler = Pointer to the caller's implementation of IWbemObjectSink. This handler receives the status of the <b>Put</b>
    ///                       request when the status becomes available using the SetStatus method. If any error code is returned, then the
    ///                       supplied <b>IWbemObjectSink</b> pointer is not used. If <b>WBEM_S_NO_ERROR</b> is returned, then the user's
    ///                       <b>IWbemObjectSink</b> implementation is called to indicate the result of the operation. Windows Management
    ///                       only calls <b>AddRef</b> to the pointer in cases where <b>WBEM_S_NO_ERROR</b> returns. In cases where an
    ///                       error code returns, the reference count is the same as on entry. For a detailed explanation of this
    ///                       parameter, see Calling a Method.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained within an <b>HRESULT</b>. Other status or error codes are reported to the object sink
    ///    specified by the <i>pReponseHandler</i> parameter. COM-specific error codes also may be returned if network
    ///    problems cause you to lose the remote connection to Windows Management. Note that if PutInstanceAsync returns
    ///    <b>WBEM_S_NO_ERROR</b>, WMI waits for a result from the <b>SetStatus</b> method of the response handler. WMI
    ///    waits indefinitely on a local connection or until a remote connection time-out occurs. Because returning
    ///    <b>WBEM_E_FAILED</b> causes other providers to not have a chance to create the class, it should only be
    ///    returned when the class provider has failed in a way that might later succeed. <div class="alert"><b>Note</b>
    ///    Unpredictable behavior will result if you change class definitions while they are in use by clients or
    ///    providers. The IWbemServices::PutClass method should only be used to create or update a class when there are
    ///    no clients or providers currently using the class.</div> <div> </div>
    ///    
    HRESULT PutClassAsync(IWbemClassObject pObject, int lFlags, IWbemContext pCtx, 
                          IWbemObjectSink pResponseHandler);
    ///The <b>IWbemServices::DeleteClass</b> method deletes the specified class from the current namespace. If a dynamic
    ///instance provider is associated with the class, the provider is unregistered, and it is no longer called for by
    ///that class. Any classes that derive from the deleted class are also deleted, and their associated providers are
    ///unregistered. All outstanding static instances of the specified class and its subclasses are also deleted when
    ///the class is deleted. If a dynamic class provider provides the class, the success of the deletion depends on
    ///whether the provider supports class deletion. <div class="alert"><b>Note</b> System classes cannot be
    ///deleted.</div><div> </div>
    ///Params:
    ///    strClass = Name of the class targeted for deletion.
    ///    lFlags = One of the following values can be set.
    ///    pCtx = Typically <b>NULL</b>. Otherwise, this is a pointer to an IWbemContext object that may be used by the
    ///           provider deleting the class. The values in the context object must be specified in the documentation for the
    ///           provider in question. For more information about this parameter, see Making Calls to WMI.
    ///    ppCallResult = If <b>NULL</b>, this parameter is not used. If <i>ppCallResult</i> is specified, it must be set to point to
    ///                   <b>NULL</b> on entry. If the <i>lFlags</i> parameter contains <b>WBEM_FLAG_RETURN_IMMEDIATELY</b>, this call
    ///                   returns immediately with <b>WBEM_S_NO_ERROR</b>. The <i>ppCallResult</i> parameter receives a pointer to a
    ///                   new IWbemCallResult object, which can then be polled to obtain the result using the GetCallStatus method.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained withinan <b>HRESULT</b>. On failure, you can obtain any available information from the COM
    ///    function GetErrorInfo. COM-specific error codes may also be returned if network problems cause you to lose
    ///    the remote connection to Windows Management.
    ///    
    HRESULT DeleteClass(const(BSTR) strClass, int lFlags, IWbemContext pCtx, IWbemCallResult* ppCallResult);
    ///The <b>IWbemServices::DeleteClassAsync</b> method deletes the specified class from the current namespace. This
    ///method is identical to IWbemServices::DeleteClass except that the call returns immediately. Confirmation or
    ///failure is asynchronously reported to the specified object sink using the IWbemObjectSink::SetStatus method after
    ///the operation is complete.
    ///Params:
    ///    strClass = Name of the class targeted for deletion.
    ///    lFlags = One or more of the following values are valid.
    ///    pCtx = Typically <b>NULL</b>. Otherwise, this is a pointer to an IWbemContext object that may be used by the
    ///           provider deleting the class. The values in the context object must be specified in the documentation for the
    ///           provider in question. For more information about this parameter, see Making Calls to WMI.
    ///    pResponseHandler = Pointer to an implementation of IWbemObjectSink implemented by the caller. This handler receives the status
    ///                       of the deletion request when it becomes available through the IWbemObjectSink::SetStatus method. If any error
    ///                       code is returned, then the supplied <b>IWbemObjectSink</b> pointer is not used. If <b>WBEM_S_NO_ERROR</b> is
    ///                       returned, then the user's <b>IWbemObjectSink</b> implementation is called to indicate the result of the
    ///                       operation. Windows Management only calls <b>AddRef</b> on the pointer in cases where <b>WBEM_S_NO_ERROR</b>
    ///                       returns. In cases where an error code returns, the reference count is the same as on entry. For a detailed
    ///                       explanation of this parameter, see Calling a Method.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained within an <b>HRESULT</b>. All other return codes are provided to the object sink specified by
    ///    the <i>pReponseHandler</i> parameter through the <b>SetStatus</b> method. Error conditions, such as when the
    ///    class does not exist or the user does not have permission to delete classes, are reported to the handler.
    ///    They are not reported in the return code of this method. COM-specific error codes also may be returned if
    ///    network problems cause you to lose the remote connection to Windows Management.
    ///    
    HRESULT DeleteClassAsync(const(BSTR) strClass, int lFlags, IWbemContext pCtx, IWbemObjectSink pResponseHandler);
    ///The <b>IWbemServices::CreateClassEnum</b> method returns an enumerator for all classes that satisfy selection
    ///criteria. The caller must use the returned enumerator to retrieve the class definitions, calling
    ///IEnumWbemClassObject::Next to obtain each class or blocks of classes. It finishes by calling
    ///IEnumWbemClassObject::Release. <div class="alert"><b>Note</b> It is not an error for the returned enumerator to
    ///have 0 (zero) elements.</div><div> </div>
    ///Params:
    ///    strSuperclass = If not <b>NULL</b> or blank, specifies a parent class name. Only classes that are subclasses of this class
    ///                    are returned in the enumerator. If it is <b>NULL</b> or blank, and <i>lFlags</i> is WBEM_FLAG_SHALLOW, only
    ///                    the top-level classes are returned (that is, classes that have no parent class). If it is <b>NULL</b> or
    ///                    blank and <i>lFlags</i> is <b>WBEM_FLAG_DEEP</b>, all classes within the namespace are returned.
    ///    lFlags = The following flags affect the behavior of this method. The suggested value for this parameter is
    ///             WBEM_FLAG_RETURN_IMMEDIATELY and WBEM_FLAG_FORWARD_ONLY for best performance.
    ///    pCtx = Typically <b>NULL</b>. Otherwise, this is a pointer to an IWbemContext object that can be used by the
    ///           provider that is providing the requested classes. The values in the context object must be specified in the
    ///           documentation for the provider. For more information about this parameter, see Making Calls to WMI.
    ///    ppEnum = Receives the pointer to the enumerator. The returned object has a positive reference count. The caller must
    ///             call Release on the pointer when it is no longer required.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> that indicates the status of a method call. The following list lists
    ///    the value contained withinan <b>HRESULT</b>. On failure, you can obtain available information from the COM
    ///    function GetErrorInfo. COM-specific error codes also can be returned if network problems cause you to lose
    ///    the remote connection to Windows Management.
    ///    
    HRESULT CreateClassEnum(const(BSTR) strSuperclass, int lFlags, IWbemContext pCtx, IEnumWbemClassObject* ppEnum);
    ///The <b>IWbemServices::CreateClassEnumAsync</b> method returns an enumeration of all classes that the class
    ///provider supports. The class provider creates each class definition from scratch and only returns subclasses of
    ///the requested class. As an asynchronous method, <b>CreateClassEnumAsync</b> returns a status message immediately
    ///and then updates the sink passed through the <i>pResponseHandler</i> parameter—if necessary. When a call
    ///succeeds, WMI calls AddRef on the pointer <i>pResponseHandler</i>, returns immediately, and then asynchronously
    ///calls <i>pResponseHandler</i>– &gt; Indicate from another thread with class definitions until the query is
    ///satisfied.
    ///Params:
    ///    strSuperclass = If not <b>NULL</b> or blank, this parameter specifies a parent class name. Only classes that are subclasses
    ///                    of this class are returned in the enumerator. If <b>NULL</b> or blank, and <i>lFlags</i> is
    ///                    <b>WBEM_FLAG_SHALLOW</b>, only top-level classes—those that have no parent class—are returned. If it is
    ///                    <b>NULL</b> or blank and <i>lFlags</i> is <b>WBEM_FLAG_DEEP</b>, all classes within the namespace are
    ///                    returned.
    ///    lFlags = One or more of the following values are valid.
    ///    pCtx = Typically <b>NULL</b>. Otherwise, this is a pointer to an IWbemContext object that can be used by the
    ///           provider that returns the requested classes. The values in the context object must be specified in the
    ///           documentation for the provider. For more information about this parameter, see Making Calls to WMI.
    ///    pResponseHandler = Pointer to the caller implementation of IWbemObjectSink. This handler receives the objects as they become
    ///                       available by using the IWbemObjectSink::Indicate method. When no objects are available, the
    ///                       IWbemObjectSink::SetStatus method is called by WMI. If any error code is returned, then the supplied
    ///                       <b>IWbemObjectSink</b> pointer is not used. If WBEM_S_NO_ERROR is returned, then the user
    ///                       <b>IWbemObjectSink</b> implementation is called to indicate the result of the operation. WMI only calls
    ///                       <b>AddRef</b> on the pointer when <b>WBEM_S_NO_ERROR</b> returns. When an error code returns, the reference
    ///                       count is the same as no entry. For a detailed explanation of this parameter, see Calling a Method.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> that indicates the status of the method call. On failure, you can
    ///    obtain available information from the COM function GetErrorInfo. COM-specific error codes can be returned if
    ///    network problems cause you to lose the remote connection to WMI. Note that if <b>CreateClassEnumAsync</b>
    ///    returns WBEM_S_NO_ERROR, WMI waits for a result from the <b>SetStatus</b> method of the response handler. WMI
    ///    waits indefinitely on a local connection or until a remote connection time-out occurs. The following list
    ///    lists the value contained within an <b>HRESULT</b>.
    ///    
    HRESULT CreateClassEnumAsync(const(BSTR) strSuperclass, int lFlags, IWbemContext pCtx, 
                                 IWbemObjectSink pResponseHandler);
    ///The <b>IWbemServices::PutInstance</b> method creates or updates an instance of an existing class. The instance is
    ///written to the WMI repository.
    ///Params:
    ///    pInst = Pointer to the instance to be written. The caller cannot make assumptions about the reference count at the
    ///            completion of this call.
    ///    lFlags = One or more of the following values can be set.
    ///    pCtx = Typically <b>NULL</b>, indicating that every property in the instance is to be updated. Otherwise, this is a
    ///           pointer to an IWbemContext object containing more information about the instance. The data in the context
    ///           object must be documented by the provider responsible for the instance. A non-<b>NULL</b><b>IWbemContext</b>
    ///           object can indicate whether support exists for partial-instance updates. For more information about how to
    ///           support full and partial-instance updates, see IWbemServices::PutInstanceAsync. For more information about
    ///           requesting a full or partial-instance update operation, see Modifying an Instance Property.
    ///    ppCallResult = If <b>NULL</b>, this parameter is not used. If the <i>lFlags</i> parameter contains
    ///                   <b>WBEM_FLAG_RETURN_IMMEDIATELY</b>, this call returns immediately with <b>WBEM_S_NO_ERROR</b>. The
    ///                   <i>ppCallResult</i> parameter then receives a pointer to a new IWbemCallResult object, which can be polled
    ///                   with IWbemCallResult::GetCallStatus to obtain the result.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained within an <b>HRESULT</b>. COM-specific error codes also may be returned if network problems
    ///    cause you to lose the remote connection to Windows Management.
    ///    
    HRESULT PutInstance(IWbemClassObject pInst, int lFlags, IWbemContext pCtx, IWbemCallResult* ppCallResult);
    ///The <b>IWbemServices::PutInstanceAsync</b> method asynchronously creates or updates an instance of an existing
    ///class. Update confirmation or error reporting is provided through the IWbemObjectSink interface implemented by
    ///the caller.
    ///Params:
    ///    pInst = Pointer to the instance to be written to the WMI repository. The caller cannot make assumptions about the
    ///            reference count at the completion of this call.
    ///    lFlags = Specifies whether the caller wants the instance created if the instance does not currently exist. When
    ///             implementing an instance provider, you can choose to support a limited number of the flags in <i>lFlags</i>
    ///             by returning <b>WBEM_E_PROVIDER_NOT_CAPABLE</b>. This property can have one or more of the following values.
    ///    pCtx = Pointer describing if the client is requesting a partial-instance update or full-instance update. A
    ///           partial-instance update modifies a subset of the properties of the instance. In contrast, a full-instance
    ///           update modifies all of the properties. If <b>NULL</b>, this parameter indicates that the caller application
    ///           is requesting a full-instance update. Otherwise, this is a pointer to an IWbemContext object required by the
    ///           dynamic class provider that is producing the class instances. For more information about this parameter, see
    ///           Making Calls to WMI.
    ///    pResponseHandler = Pointer to the caller's implementation of IWbemObjectSink. This handler receives the status of this call when
    ///                       it becomes available using the IWbemObjectSink::SetStatus method. If any error code is returned, then the
    ///                       supplied <b>IWbemObjectSink</b> pointer is not used. If <b>WBEM_S_NO_ERROR</b> is returned, then the user's
    ///                       <b>IWbemObjectSink</b> implementation is called to indicate the result of the operation. Windows Management
    ///                       only calls <b>AddRef</b> on the pointer in cases where <b>WBEM_S_NO_ERROR</b> returns. In cases where an
    ///                       error code returns, the reference count is the same as on entry. For more information about how to make
    ///                       asynchronous calls, see Calling a Method.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained within an <b>HRESULT</b>. Note that if <b>PutInstanceAsync</b> returns
    ///    <b>WBEM_S_NO_ERROR</b>, WMI waits for a result from the <b>SetStatus</b> method of the response handler. WMI
    ///    waits indefinitely on a local connection or until a remote connection time-out occurs. COM-specific error
    ///    codes also may be returned if network problems cause you to lose the remote connection to Windows Management.
    ///    
    HRESULT PutInstanceAsync(IWbemClassObject pInst, int lFlags, IWbemContext pCtx, 
                             IWbemObjectSink pResponseHandler);
    ///The <b>IWbemServices::DeleteInstance</b> method deletes an instance of an existing class in the current
    ///namespace.
    ///Params:
    ///    strObjectPath = Valid <b>BSTR</b> containing the object path to the instance to be deleted.
    ///    lFlags = One of the following values are valid.
    ///    pCtx = Typically NULL. Otherwise, this is a pointer to an IWbemContext object that may be used by the provider that
    ///           is deleting the instance. The values in the context object must be specified in the documentation for the
    ///           provider in question.
    ///    ppCallResult = If NULL, this parameter is not used. If <i>ppCallResult</i> is specified, it must be set to point to
    ///                   <b>NULL</b> on entry. If the <i>lFlags</i> parameter contains <b>WBEM_FLAG_RETURN_IMMEDIATELY</b>, this call
    ///                   returns immediately with <b>WBEM_S_NO_ERROR</b>. The <i>ppCallResult</i> parameter receives a pointer to a
    ///                   new IWbemCallResult object, which can then be polled to obtain the result using the GetCallStatus method.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> that indicates the status of the method call. The following list lists
    ///    the value contained within an <b>HRESULT</b>. On failure, you can obtain any available information from the
    ///    COM function GetErrorInfo. COM-specific error codes also may be returned if network problems cause you to
    ///    lose the remote connection to Windows Management.
    ///    
    HRESULT DeleteInstance(const(BSTR) strObjectPath, int lFlags, IWbemContext pCtx, IWbemCallResult* ppCallResult);
    ///The <b>IWbemServices::DeleteInstanceAsync</b> method asynchronously deletes an instance of an existing class in
    ///the current namespace. The confirmation or failure of the operation is reported through the IWbemObjectSink
    ///interface implemented by the caller.
    ///Params:
    ///    strObjectPath = Valid <b>BSTR</b> that contains the object path of the object to be deleted.
    ///    lFlags = <b>WBEM_FLAG_SEND_STATUS</b> registers with Windows Management a request to receive intermediate status
    ///             reports through the client's implementation of IWbemObjectSink::SetStatus. Provider implementation must
    ///             support intermediate status reporting, for this flag to change behavior. Note that the
    ///             <b>WBEM_FLAG_USE_AMENDED_QUALIFIERS</b> flag cannot be used here.
    ///    pCtx = Typically <b>NULL</b>. Otherwise, this is a pointer to an IWbemContext object that may be used by the
    ///           provider that is deleting the instance. The values in the context object must be specified in the
    ///           documentation for the provider in question.
    ///    pResponseHandler = Pointer to the caller's implementation of IWbemObjectSink. This handler receives the status of the delete
    ///                       operation as it becomes available through the SetStatus method. If any error code is returned, then the
    ///                       supplied <b>IWbemObjectSink</b> pointer is not used. If <b>WBEM_S_NO_ERROR</b> is returned, then the user's
    ///                       <b>IWbemObjectSink</b> implementation is called to indicate the result of the operation. Windows Management
    ///                       only calls AddRef on the pointer in cases where <b>WBEM_S_NO_ERROR</b> returns. In cases where an error code
    ///                       returns, the reference count is the same as on entry. For more information, see Calling a Method.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> that indicates the status of the method call. The following list lists
    ///    the value contained withinan <b>HRESULT</b>. On failure, you can obtain any available information from the
    ///    COM function GetErrorInfo. If <b>DeleteInstanceAsync</b> returns <b>WBEM_S_NO_ERROR</b>, WMI waits for a
    ///    result from the <b>SetStatus</b> method of the response handler. WMI waits indefinitely on a local
    ///    connection, or until a remote connection time-out occurs. Other error conditions are reported asynchronously
    ///    to the object sink supplied by the <i>pResponseHandler</i> parameter. COM-specific error codes also may be
    ///    returned if network problems cause you to lose the remote connection to Windows Management. <div
    ///    class="alert"><b>Note</b> Clients that call <b>DeleteInstanceAsync</b> must always expect the results of the
    ///    call to be reported using their IWbemObjectSink::Indicate method.</div> <div> </div> <div
    ///    class="alert"><b>Note</b> When the instance pointed to by <i>strObjectPath</i> belongs to a class that is a
    ///    member of a class hierarchy, the success of <b>DeleteInstanceAsync</b> depends on the topmost non-abstract
    ///    provider. For a detailed explanation of the dependencies involved that determine the success of this
    ///    operation, see Remarks in IWbemServices::DeleteInstance.</div> <div> </div>
    ///    
    HRESULT DeleteInstanceAsync(const(BSTR) strObjectPath, int lFlags, IWbemContext pCtx, 
                                IWbemObjectSink pResponseHandler);
    ///The <b>IWbemServices::CreateInstanceEnum</b> method creates an enumerator that returns the instances of a
    ///specified class according to user-specified selection criteria. This method supports simple WQL queries; more
    ///complex queries can be processed using the IWbemServices::ExecQuery method.
    ///Params:
    ///    strFilter = Valid <b>BSTR</b> containing the name of the class for which instances are desired. This parameter cannot be
    ///                <b>NULL</b>.
    ///    lFlags = The following flags affect the behavior of this method. The suggested value for this parameter is
    ///             <b>WBEM_FLAG_RETURN_IMMEDIATELY</b> and <b>WBEM_FLAG_FORWARD_ONLY</b> for best performance.
    ///    pCtx = Typically <b>NULL</b>. Otherwise, this is a pointer to an IWbemContext object that may be used by the
    ///           provider that is providing the requested instances. The values in the context object must be specified in the
    ///           documentation for the provider in question. For more information about this parameter, see Making Calls to
    ///           WMI.
    ///    ppEnum = Receives the pointer to the enumerator, which has a positive reference count. The caller must call
    ///             <b>IUnknown::Release</b> on the pointer after it is no longer required.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained withinan <b>HRESULT</b>. On failure, you can obtain any available information from the COM
    ///    function GetErrorInfo. COM-specific error codes also may be returned if network problems cause you to lose
    ///    the remote connection to Windows Management.
    ///    
    HRESULT CreateInstanceEnum(const(BSTR) strFilter, int lFlags, IWbemContext pCtx, IEnumWbemClassObject* ppEnum);
    ///The <b>IWbemServices::CreateInstanceEnumAsync</b> method creates an enumerator that asynchronously returns the
    ///instances of a specified class according to user-specified selection criteria. This method supports simple WMI
    ///Query Language (WQL) queries. More complex queries can be processed using the IWbemServices::ExecQueryAsync
    ///method.
    ///Params:
    ///    strFilter = Valid <b>BSTR</b> containing the name of the class for which instances are desired. This parameter cannot be
    ///                <b>NULL</b>.
    ///    lFlags = This parameter can be one of the following values.
    ///    pCtx = Typically NULL. Otherwise, this is a pointer to an IWbemContext object that may be used by the provider that
    ///           is returning the requested instances. The values in the context object must be specified in the documentation
    ///           for the provider in question. For more information, see Making Calls to WMI.
    ///    pResponseHandler = Pointer to the caller's implementation of IWbemObjectSink. This handler receives the objects as they become
    ///                       available. If any error code is returned, then the supplied <b>IWbemObjectSink</b> pointer is not used. If
    ///                       <b>WBEM_S_NO_ERROR</b> is returned, then the user's <b>IWbemObjectSink</b> implementation will be called to
    ///                       indicate the result of the operation. Windows Management only calls AddRef on the pointer in cases where
    ///                       <b>WBEM_S_NO_ERROR</b> returns. In cases where an error code returns, the reference count is the same as on
    ///                       entry. For more information, see Calling a Method.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained within an <b>HRESULT</b>. On failure, you can obtain more information from the COM function
    ///    GetErrorInfo. COM-specific error codes also may be returned if network problems cause you to lose the remote
    ///    connection to Windows Management. An instance provider can report success or failure with either the return
    ///    code from <b>CreateInstanceEnumAsync</b>, or through a call to SetStatus made through
    ///    <i>pResponseHandler</i>. If you choose to call <b>SetStatus</b>, the return code sent through
    ///    <i>pResponseHandler</i> takes precedence. If <b>CreateInstanceEnumAsync</b> returns <b>WBEM_S_NO_ERROR</b>,
    ///    WMI waits for a result from the SetStatus method of the response handler. WMI waits indefinitely on a local
    ///    connection, or until a remote connection time-out occurs.
    ///    
    HRESULT CreateInstanceEnumAsync(const(BSTR) strFilter, int lFlags, IWbemContext pCtx, 
                                    IWbemObjectSink pResponseHandler);
    ///The <b>IWbemServices::ExecQuery</b> method executes a query to retrieve objects. For the valid types of queries
    ///that can be performed, see Querying with WQL.
    ///Params:
    ///    strQueryLanguage = Valid <b>BSTR</b> that contains one of the query languages supported by Windows Management. This must be
    ///                       "WQL", the acronym for WMI Query Language.
    ///    strQuery = Valid <b>BSTR</b> that contains the text of the query. This parameter cannot be <b>NULL</b>. For more
    ///               information on building WMI query strings, see Querying with WQL and the WQL reference.
    ///    lFlags = The following flags affect the behavior of this method. The suggested value for this parameter is
    ///             <b>WBEM_FLAG_RETURN_IMMEDIATELY</b> and <b>WBEM_FLAG_FORWARD_ONLY</b> for best performance.
    ///    pCtx = Typically <b>NULL</b>. Otherwise, this is a pointer to an IWbemContext object that can be used by the
    ///           provider that is providing the requested classes or instances. The values in the context object must be
    ///           specified in the documentation for the provider in question. For more information about this parameter, see
    ///           Making Calls to WMI.
    ///    ppEnum = If no error occurs, this receives the enumerator that allows the caller to retrieve the instances in the
    ///             result set of the query. It is not an error for the query to have a result set with 0 instances. This is
    ///             determined only by attempting to iterate through the instances. This object returns with a positive reference
    ///             count. The caller must call Release when the object is no longer required.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> that indicates the status of the method call. The following list lists
    ///    the value contained within an <b>HRESULT</b>. On failure, you can obtain any available information from the
    ///    COM function GetErrorInfo. COM-specific error codes also can be returned if network problems cause you to
    ///    lose the remote connection to Windows Management.
    ///    
    HRESULT ExecQuery(const(BSTR) strQueryLanguage, const(BSTR) strQuery, int lFlags, IWbemContext pCtx, 
                      IEnumWbemClassObject* ppEnum);
    ///The <b>IWbemServices::ExecQueryAsync</b> method executes a query to retrieve objects asynchronously.
    ///Params:
    ///    strQueryLanguage = Valid <b>BSTR</b> that contains one of the query languages that Windows Management Instrumentation (WMI)
    ///                       supports. This must be "WQL".
    ///    strQuery = Valid <b>BSTR</b> that contains the text of the query. This cannot be <b>NULL</b>. When you implement an
    ///               instance provider, your provider can refuse the query because it is too complex. When a provider determines
    ///               that a query is too complex, WMI can retry the provider with a simple query, or choose to retrieve and
    ///               enumerate the superset of the query instances. For more information on building WMI query strings, see
    ///               Querying with WQL and the WQL reference.
    ///    lFlags = This parameter can be one of the following values.
    ///    pCtx = Typically <b>NULL</b>. Otherwise, this is a pointer to an IWbemContext object that the provider can use to
    ///           return the requested classes or instances. The values in the context object must be specified in the
    ///           documentation for the provider. For more information about this parameter, see Making Calls to WMI.
    ///    pResponseHandler = Pointer to the caller's implementation of IWbemObjectSink. This handler receives the objects in the query
    ///                       result set as they become available. If any error code is returned, then the supplied <b>IWbemObjectSink</b>
    ///                       pointer is not used. If <b>WBEM_S_NO_ERROR</b> is returned, then the user's <b>IWbemObjectSink</b>
    ///                       implementation is called to indicate the result of the operation. Windows Management Instrumentation (WMI)
    ///                       calls IWbemObjectSink::Indicate with the objects any number of times, followed by a single call to
    ///                       IWbemObjectSink::SetStatus to indicate the final status. WMI only calls AddRef to the pointer when
    ///                       <b>WBEM_S_NO_ERROR</b> returns. When an error code returns, the reference count is the same as on entry. For
    ///                       a detailed explanation of asynchronous calling methods, see Calling a Method.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> that indicates the status of the method call. The following list lists
    ///    the value contained within an <b>HRESULT</b>. When there is a failure, you can obtain information from the
    ///    COM function GetErrorInfo. Other error codes are returned to the object sink specified by the
    ///    <i>pResponseHandler</i> parameter. COM-specific error codes might be returned if network problems cause you
    ///    to lose the remote connection to WMI. When finished, an instance provider can report success or failure with
    ///    either the return code from <b>ExecQueryAsync</b> or through a call to SetStatus made through
    ///    <i>pResponseHandler</i>. If you choose to call <b>SetStatus</b>, the return code sent through
    ///    <i>pResponseHandler</i> takes precedence.
    ///    
    HRESULT ExecQueryAsync(const(BSTR) strQueryLanguage, const(BSTR) strQuery, int lFlags, IWbemContext pCtx, 
                           IWbemObjectSink pResponseHandler);
    ///The <b>IWbemServices::ExecNotificationQuery</b> method executes a query to receive events. The call returns
    ///immediately, and the user can poll the returned enumerator for events as they arrive. Releasing the returned
    ///enumerator cancels the query.
    ///Params:
    ///    strQueryLanguage = Valid <b>BSTR</b> that contains one of the query languages supported by Windows Management. This cannot be
    ///                       <b>NULL</b>. Currently, only the WMI Query Language (WQL) is supported.
    ///    strQuery = Valid <b>BSTR</b> that contains the text of the event-related query. This cannot be <b>NULL</b>. For more
    ///               information on building WMI query strings, see Querying with WQL and the WQL reference.
    ///    lFlags = This parameter must be set to both <b>WBEM_FLAG_RETURN_IMMEDIATELY</b> and <b>WBEM_FLAG_FORWARD_ONLY</b> or
    ///             the call fails.
    ///    pCtx = Typically <b>NULL</b>. Otherwise, this is a pointer to an IWbemContext object that can be used by the
    ///           provider that provides the requested events. The values in the context object must be specified in the
    ///           documentation for the provider in question. For more information about this parameter, see Making Calls to
    ///           WMI.
    ///    ppEnum = If no error occurs, this parameter receives the enumerator that allows the caller to retrieve the instances
    ///             in the result set of the query. The caller periodically calls IEnumWbemClassObject::Next to see if any events
    ///             are available. Notice that, in this usage, Reset does not move the enumerator back to the beginning of the
    ///             event sequence; it has no effect. The parameter can continue to receive events until Release is called on the
    ///             returned enumerator.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> that indicates the status of the method call. The following list lists
    ///    the value contained within an <b>HRESULT</b>. On failure, you can obtain any available information from the
    ///    COM function GetErrorInfo. COM-specific error codes also can be returned if network problems cause you to
    ///    lose the remote connection to Windows Management.
    ///    
    HRESULT ExecNotificationQuery(const(BSTR) strQueryLanguage, const(BSTR) strQuery, int lFlags, 
                                  IWbemContext pCtx, IEnumWbemClassObject* ppEnum);
    ///The <b>IWbemServices::ExecNotificationQueryAsync</b> method performs the same task as
    ///IWbemServices::ExecNotificationQuery except that events are supplied to the specified response handler until
    ///CancelAsyncCall is called to stop the event notification.
    ///Params:
    ///    strQueryLanguage = Valid <b>BSTR</b> that contains one of the query languages supported by Windows Management. This must be
    ///                       "WQL".
    ///    strQuery = Valid <b>BSTR</b> that contains the text of the event-related query. This cannot be <b>NULL</b>. For more
    ///               information on building WMI query strings, see Querying with WQL and the WQL reference.
    ///    lFlags = This parameter can be the following value.
    ///    pCtx = Typically <b>NULL</b>. Otherwise, this is a pointer to an IWbemContext object that may be used by the
    ///           provider that is returning the requested events. The values in the context object must be specified in the
    ///           documentation for the provider in question. For more information about this parameter, see Making Calls to
    ///           WMI.
    ///    pResponseHandler = Pointer to the caller's implementation of IWbemObjectSink. This handler receives the objects in the query
    ///                       result set as they become available. To cease receiving events, the caller must call
    ///                       IWbemServices::CancelAsyncCall using the same pointer value for <i>pResponseHandler</i>. As events become
    ///                       available, the supplied IWbemObjectSink::Indicate implementation is called to deliver the event objects. The
    ///                       IWbemObjectSink::SetStatus method is not called at any time, because there is no final or terminating
    ///                       condition. The call executes indefinitely until canceled. If any error code is returned, then the supplied
    ///                       <b>IWbemObjectSink</b> pointer is not used. If <b>WBEM_S_NO_ERROR</b> is returned, then the user's
    ///                       <b>IWbemObjectSink</b> implementation is called to indicate the result of the operation. Windows Management
    ///                       only calls AddRef on the pointer in cases where <b>WBEM_S_NO_ERROR</b> returns. In cases where an error code
    ///                       returns, the reference count is the same as on entry. For a detailed explanation of this parameter, see
    ///                       Calling a Method.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained within an <b>HRESULT</b>. On failure, you can obtain any available information from the COM
    ///    function GetErrorInfo. Other error codes are returned to the object sink specified by the
    ///    <i>pResponseHandler</i> parameter. COM-specific error codes also can be returned if network problems cause
    ///    you to lose the remote connection to Windows Management.
    ///    
    HRESULT ExecNotificationQueryAsync(const(BSTR) strQueryLanguage, const(BSTR) strQuery, int lFlags, 
                                       IWbemContext pCtx, IWbemObjectSink pResponseHandler);
    ///The <b>IWbemServices::ExecMethod</b> method executes a method exported by a CIM object. The method call is
    ///forwarded to the appropriate provider where it executes. Information and status are returned to the caller, which
    ///blocks until the call is complete. Methods are not directly implemented by Windows Management, but are exported
    ///by method providers. For any given CIM class, the available methods and their parameters must be specified in the
    ///documentation for the provider in question. For more information about executing methods, see Calling a Method.
    ///Params:
    ///    strObjectPath = Valid <b>BSTR</b> containing the object path of the object for which the method is executed.
    ///    strMethodName = Name of the method for the object.
    ///    lFlags = This parameter can be set to 0 to make this a synchronous call. To make this a semisynchronous call, set
    ///             <i>lFlags</i> to <b>WBEM_FLAG_RETURN_IMMEDIATELY</b>, provide a valid pointer for the <i>ppCallResult</i>
    ///             parameter, and this call returns immediately. For more information, see Calling a Method.
    ///    pCtx = Typically <b>NULL</b>; otherwise, this is a pointer to an IWbemContext object that may be used by the
    ///           provider executing the method. The values in the context object must be specified in the documentation for
    ///           the provider in question. For more information about this parameter, see Making Calls to WMI.
    ///    pInParams = May be <b>NULL</b> if no in-parameters are required to execute the method. Otherwise, this points to an
    ///                IWbemClassObject that contains the properties acting as inbound parameters for the method execution. The
    ///                contents of the object are method-specific, and are part of the specification for the provider in question.
    ///                For more information about constructing input parameters, see Creating Parameters Objects in C++.
    ///    ppOutParams = If not <b>NULL</b>, receives a pointer to the outbound parameters and return values for the method execution.
    ///                  The contents of this object are method-specific, and are part of the specification for the provider in
    ///                  question. The caller must call Release on the returned object when it is no longer required.
    ///    ppCallResult = If <b>NULL</b>, this is not used. If <i>ppCallResult</i> is specified, it must be set to point to <b>NULL</b>
    ///                   on entry. In this case, the call returns immediately with <b>WBEM_S_NO_ERROR</b>. The <i>ppCallResult</i>
    ///                   parameter receives a pointer to a new IWbemCallResult object, which must be polled to obtain the result of
    ///                   the method execution using the GetCallStatus method. The out parameters for the call are available by calling
    ///                   IWbemCallResult::GetResultObject.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained within an <b>HRESULT</b>. On failure, you can obtain any available information from the COM
    ///    function GetErrorInfo. COM-specific error codes also may be returned if network problems cause you to lose
    ///    the remote connection to Windows Management.
    ///    
    HRESULT ExecMethod(const(BSTR) strObjectPath, const(BSTR) strMethodName, int lFlags, IWbemContext pCtx, 
                       IWbemClassObject pInParams, IWbemClassObject* ppOutParams, IWbemCallResult* ppCallResult);
    ///The <b>IWbemServices::ExecMethodAsync</b> method asynchronously executes a method exported by a CIM object. The
    ///call immediately returns to the client while the inbound parameters are forwarded to the appropriate provider
    ///where it executes. Information and status are returned to the caller through the supplied object sink. Methods
    ///are not directly implemented by Windows Management, but are exported by method providers. For any given CIM
    ///class, the available methods and their parameters are part of the documentation for the provider in question.
    ///Params:
    ///    strObjectPath = Valid <b>BSTR</b> containing the object path of the object for which the method is to be executed. You can
    ///                    invoke a static method using either a class name or an object path to an instance. The method provider can
    ///                    parse the object path parameter to determine the class and instance that contain the method definition.
    ///    strMethodName = Name of the method for the object.
    ///    lFlags = <b>WBEM_FLAG_SEND_STATUS</b> registers with Windows Management a request to receive intermediate status
    ///             reports through the clients implementation of IWbemObjectSink::SetStatus. Provider implementation must
    ///             support intermediate status reporting for this flag to change behavior. Note that the
    ///             <b>WBEM_FLAG_USE_AMENDED_QUALIFIERS</b> flag cannot be used here.
    ///    pCtx = Typically <b>NULL</b>; otherwise, this is a pointer to an IWbemContext object that may be used by the
    ///           provider executing the method. The values in the context object must be specified in the documentation for
    ///           the provider in question. For more information about this parameter, see Making Calls to WMI.
    ///    pInParams = Can be <b>NULL</b> if no inbound parameters are required to execute the method. Otherwise, this points to an
    ///                IWbemClassObject object that contains the properties acting as inbound parameters for the method execution.
    ///                The contents of the object are method-specific, and are part of the specification for the provider in
    ///                question. However, the most common object is an instance of the __Parameters system class. For each input
    ///                parameter to the method to be called, there is one non-system property. Method providers ignore the ID
    ///                qualifiers attached to each parameter in the method, which are typically used only by browsers and similar
    ///                applications.
    ///    pResponseHandler = Cannot be <b>NULL</b>. The object sink receives the result of the method call. The outbound parameters are
    ///                       sent to IWbemObjectSink::Indicate. The most common returned object is an instance of the __Parameters system
    ///                       class. For more information about return codes, see the Remarks section. When implementing a method provider,
    ///                       you should call <b>Indicate</b> to return output parameter information before calling
    ///                       IWbemObjectSink::SetStatus to report the final status.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained within an <b>HRESULT</b>. On failure, you can obtain any available information from the COM
    ///    function GetErrorInfo. Other errors are reported asynchronously to the object sink supplied in the
    ///    <i>pReponseHandler</i> parameter. COM-specific error codes also may be returned if network problems cause you
    ///    to lose the remote connection to WMI.
    ///    
    HRESULT ExecMethodAsync(const(BSTR) strObjectPath, const(BSTR) strMethodName, int lFlags, IWbemContext pCtx, 
                            IWbemClassObject pInParams, IWbemObjectSink pResponseHandler);
}

///Use the <b>IWbemLocator</b> interface to obtain the initial namespace pointer to the IWbemServices interface for WMI
///on a specific host computer. You can access Windows Management itself using the <b>IWbemServices</b> pointer, which
///is returned by the IWbemLocator::ConnectServer method. A client or provider that requires Windows Management services
///first obtains a pointer to the locator using CoCreateInstance or CoCreateInstanceEx, as specified in the COM
///documentation in the Microsoft Windows Software Development Kit (SDK). The <b>IWbemLocator</b> object is always an
///in-process COM server. The interface pointer to the desired namespace on the desired target computer is then obtained
///through the IWbemLocator::ConnectServer method, which is the only method on this interface.
@GUID("DC12A687-737F-11CF-884D-00AA004B2E24")
interface IWbemLocator : IUnknown
{
    ///The <b>IWbemLocator::ConnectServer</b> method creates a connection through DCOM to a WMI namespace on the
    ///computer specified in the <i>strNetworkResource</i> parameter. SWbemLocator.ConnectServer can connect with
    ///computers running IPv6 using an IPv6 address in the <i>strNetworkResource</i> parameter. For more information,
    ///see IPv6 and IPv4 Support in WMI.
    ///Params:
    ///    strNetworkResource = Pointer to a valid <b>BSTR</b> that contains the object path of the correct WMI namespace. For local access
    ///                         to the default namespace, use a simple object path: "root\default" or "\\.\root\default". For access to the
    ///                         default namespace on a remote computer using COM or Microsoft-compatible networking, include the computer
    ///                         name: "\\myserver\root\default". For more information, see Describing a WMI Namespace Object Path. The
    ///                         computer name also can be a DNS name or IP address. Starting with Windows Vista, SWbemLocator.ConnectServer
    ///                         can connect with computers running IPv6 using an IPv6 address. For more information, see IPv6 and IPv4
    ///                         Support in WMI.
    ///    strUser = Pointer to a valid <b>BSTR</b>, which contains the user name you need for a connection. A <b>NULL</b> value
    ///              indicates the current security context. If the user name is from a domain different from the current domain,
    ///              the string may contain the domain name and user name separated by a backslash. <code>StrUserName =
    ///              SysAllocString(L"Domain\\UserName");</code> The <i>strUser</i> parameter cannot be an empty string. Note that
    ///              if the domain is specified in <i>strAuthority</i>, then it must not be specified here. Specifying the domain
    ///              in both parameters results in an invalid parameter error. You can use the user principal name (UPN) format,
    ///              which is <i>Username@DomainName</i> to specify the <i>strUser</i>.
    ///    strPassword = Pointer to a valid <b>BSTR</b> that contains the password you need for a connection. A <b>NULL</b> value
    ///                  indicates the current security context. A blank string "" specifies a valid zero-length password.
    ///    strLocale = If <b>NULL</b>, the current locale is used. If not <b>NULL</b>, this parameter must be a valid <b>BSTR</b>,
    ///                which indicates the correct locale for information retrieval. For Microsoft locale identifiers, the format of
    ///                the string is "MS_xxx", where xxx is a string in hexadecimal form that indicates the Local Identification
    ///                (LCID), for example, American English would appear as "MS_409". If an invalid locale is specified, then the
    ///                method returns <b>WBEM_E_INVALID_PARAMETER</b>. <b>Windows 7: </b>If an invalid locale is specified, then the
    ///                default locale of the server is used unless there is a server-supported locale provided by the user
    ///                application.
    ///    lSecurityFlags = Long value used to pass flag values to <b>ConnectServer</b>. A value of zero (0) for this parameter results
    ///                     in the call to <b>ConnectServer</b> returning only after connection to the server is established. This could
    ///                     result in your program ceasing to respond indefinitely if the server is broken. The following list lists the
    ///                     other valid values for <i>lSecurityFlags</i>.
    ///    strAuthority = This parameter contains the name of the domain of the user to authenticate. <i>strAuthority</i> can have the
    ///                   following values: <ul> <li> blank If you leave this parameter blank, NTLM authentication is used and the NTLM
    ///                   domain of the current user is used. If the domain is specified in <i>strUser</i>, which is the recommended
    ///                   location, then it must not be specified here. Specifying the domain in both parameters results in an invalid
    ///                   parameter error. </li> <li> Kerberos:&lt;<i>principal name</i>&gt; Kerberos authentication is used and this
    ///                   parameter should contain a Kerberos principal name. </li> <li> NTLMDOMAIN:&lt;<i>domain name</i>&gt; NT LAN
    ///                   Manager authentication is used and this parameter should contain an NTLM domain name. </li> </ul>
    ///    pCtx = Typically, this is <b>NULL</b>. Otherwise, this is a pointer to an IWbemContext object required by one or
    ///           more dynamic class providers. The values in the context object must be specified in the documentation for the
    ///           providers in question. For more information about this parameter, see Making Calls to WMI.
    ///    ppNamespace = Receives a pointer to an IWbemServices object bound to the specified namespace. This pointer has a positive
    ///                  reference count. The caller must call IWbemServices::Release on the pointer when it is no longer required.
    ///                  This pointer is set to point to <b>NULL</b> when there is an error.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> that indicates the status of the method call. The following list lists
    ///    the value contained within an <b>HRESULT</b>. COM-specific error codes may be returned if network problems
    ///    cause you to lose the remote connection to WMI. These error return codes are defined in the Wbemcli.h file in
    ///    the WMI section of the PSDK \Include directory. For more information see WMI Error Constants.
    ///    
    HRESULT ConnectServer(const(BSTR) strNetworkResource, const(BSTR) strUser, const(BSTR) strPassword, 
                          const(BSTR) strLocale, int lSecurityFlags, const(BSTR) strAuthority, IWbemContext pCtx, 
                          IWbemServices* ppNamespace);
}

///The <b>IWbemObjectSink</b> interface creates a sink interface that can receive all types of notifications within the
///WMI programming model. Clients must implement this interface to receive both the results of the asynchronous methods
///of IWbemServices, and specific types of event notifications. Providers use, but do not implement this interface to
///provide events and objects to WMI. Typically, providers call an implementation provided to them by WMI. In these
///cases, call Indicate to provide objects to the WMI service. After that, call SetStatus to indicate the end of the
///notification sequence. You can also call <b>SetStatus</b> to indicate errors when the sink does not have any objects.
///When programming asynchronous clients of WMI, the user provides the implementation. WMI calls the methods to deliver
///objects and set the status of the result. <div class="alert"><b>Note</b> If a client application passes the same sink
///interface in two different overlapping asynchronous calls, WMI does not guarantee the order of the callback. Client
///applications that make overlapping asynchronous calls should either pass different sink objects, or serialize their
///calls.</div><div> </div><div class="alert"><b>Note</b> Because the call-back to the sink might not be returned at the
///same authentication level as the client requires, it is recommended that you use semisynchronous instead of
///asynchronous communication. For more information, see Calling a Method.</div><div> </div>
@GUID("7C857801-7381-11CF-884D-00AA004B2E24")
interface IWbemObjectSink : IUnknown
{
    ///The <b>Indicate</b> method is called by a source to provide a notification. Typically, WMI calls the client
    ///implementation of this interface after the client executes one of the asynchronous methods of IWbemServices. In
    ///other cases, various types of providers call an implementation exported by WMI to deliver events. Therefore,
    ///client code may have to implement this interface in some cases, and use a different component's implementation in
    ///other cases. Use this interface and method in conjunction with the asynchronous methods of the IWbemServices
    ///interface. Clients and providers must implement this interface to receive notifications or to execute the
    ///asynchronous methods of IWbemServices. For more information, see Calling a Method.
    ///Params:
    ///    lObjectCount = Number of objects in the following array of pointers.
    ///    apObjArray = Array of pointers to IWbemClassObject interfaces. The array memory itself is read-only, and is owned by the
    ///                 caller of the method. Because this is an in parameter, the implementation has the option of calling
    ///                 IWbemClassObject::AddRef on any object pointer in the array and holding it before returning if the objects
    ///                 will be used after the method has returned, in accordance with COM rules. If the objects are only used for
    ///                 the duration of the <b>Indicate</b> call, then you do not need to call <b>AddRef</b> on each object pointer.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> that indicates the status of the method call. The following list lists
    ///    the value contained within an <b>HRESULT</b>.
    ///    
    HRESULT Indicate(int lObjectCount, IWbemClassObject* apObjArray);
    ///The <b>IWbemObjectSink::SetStatus</b> method is called by sources to indicate the end of a notification sequence,
    ///or to send other status codes to the sink. The IWbemObjectSink::Indicate method may or may not have been called
    ///before the call to <b>SetStatus</b>. Typically, a client implements the IWbemObjectSink interface, and executes
    ///IWbemServices methods that return their results using the <b>IWbemObjectSink</b> interface. During this
    ///operation, WMI calls Indicate as many times as required, followed by a final call to <b>SetStatus</b>, and in
    ///many cases, Release.
    ///Params:
    ///    lFlags = Bitmask of status information. The status of the operation can be obtained by examining the <i>hResult</i>
    ///             parameter.
    ///    hResult = This parameter is set to the <b>HRESULT</b> of the asynchronous operation or notification. This is either an
    ///              error code, if an error occurred, or the amount of progress that has been made on an asynchronous call.
    ///    strParam = Receives a pointer to a read-only <b>BSTR</b>, if the original asynchronous operation returns a string. For
    ///               example, when using PutInstanceAsync, <b>SetStatus</b> is called with this parameter set to the object path
    ///               of the newly created instance.
    ///    pObjParam = In cases where a complex error or status object is returned, this contains a pointer to the error object. If
    ///                the object is required after <b>SetStatus</b> returns, the called object must use the AddRef method on the
    ///                pointer before the called object returns.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained within an <b>HRESULT</b>.
    ///    
    HRESULT SetStatus(int lFlags, HRESULT hResult, BSTR strParam, IWbemClassObject pObjParam);
}

///The <b>IEnumWbemClassObject</b> interface is used to enumerate Common Information Model (CIM) objects and is similar
///to a standard COM enumerator. An object of type <b>IEnumWbemClassObject</b> is received from calls to the following
///methods: <ul> <li> IWbemServices::ExecQuery </li> <li> IWbemServices::CreateInstanceEnum </li> <li>
///IWbemServices::CreateClassEnum </li> <li> IWbemServices::ExecNotificationQuery </li> </ul>CIM objects are retrieved
///from an enumeration as objects of type IWbemClassObject by calling the Next method. You can reset an enumeration back
///to the beginning by calling the Reset method.
@GUID("027947E1-D731-11CE-A357-000000000001")
interface IEnumWbemClassObject : IUnknown
{
    ///The <b>IEnumWbemClassObject::Reset</b> method resets an enumeration sequence back to the beginning. Because CIM
    ///objects are dynamic, calling this method does not necessarily return the same list of objects that you obtained
    ///previously. <div class="alert"><b>Note</b> This method fails if the enumerator was originally created with the
    ///<b>WBEM_FLAG_FORWARD_ONLY</b> option.</div><div> </div>
    ///Returns:
    ///    The <b>Reset</b> method returns an <b>HRESULT</b> indicating the status of the method call. The following
    ///    list lists the value contained within an <b>HRESULT</b>.
    ///    
    HRESULT Reset();
    ///Use the <b>IEnumWbemClassObject::Next</b> method to get one or more objects starting at the current position in
    ///an enumeration. This method advances the current position in the enumeration by <i>uCount</i> objects, so that
    ///subsequent calls return the subsequent objects.
    ///Params:
    ///    lTimeout = Specifies the maximum amount of time in milliseconds that the call blocks before returning. If you use the
    ///               constant <b>WBEM_INFINITE</b> (0xFFFFFFFF), the call blocks until objects are available. If you use the value
    ///               0 (<b>WBEM_NO_WAIT</b>), the call returns immediately, whether any objects are available or not.
    ///    uCount = Number of requested objects.
    ///    apObjects = Pointer to enough storage to hold the number of IWbemClassObject interface pointers specified by
    ///                <i>uCount</i>. This storage must be supplied by the caller. This parameter cannot be <b>NULL</b>. The caller
    ///                must call <b>Release</b> on each of the received interface pointers when they are no longer needed.
    ///    puReturned = Pointer to a <b>ULONG</b> that receives the number of objects returned. This number can be less than the
    ///                 number requested in <i>uCount</i>. This pointer cannot be <b>NULL</b>. <div class="alert"><b>Note</b> The
    ///                 <b>Next</b> method returns <b>WBEM_S_FALSE</b> when you have reached the end of the enumeration, even if
    ///                 objects have been returned successfully. The <b>WBEM_S_NO_ERROR</b> value returns only when the number of
    ///                 objects returned matches the number requested in <i>uCount</i>. The <b>WBEM_S_TIMEDOUT</b> value is returned
    ///                 when the number of objects returned is less than the number requested but you are not at the end of the
    ///                 enumeration. Therefore, you should use loop termination logic that examines the <i>puReturned</i> value to
    ///                 ensure that you have reached the end of the enumeration.</div> <div> </div>
    ///Returns:
    ///    The <b>Next</b> method returns an <b>HRESULT</b> indicating the status of the method call. The following list
    ///    lists the value contained within an <b>HRESULT</b>.
    ///    
    HRESULT Next(int lTimeout, uint uCount, IWbemClassObject* apObjects, uint* puReturned);
    ///Use the <b>NextAsync</b> method when a controlled asynchronous retrieval of objects to a sink is required. Normal
    ///asynchronous retrieval, such as a call to IWbemServices::ExecQueryAsync, results in uncontrolled delivery of
    ///objects to the caller's implementation of IWbemObjectSink. This method is helpful for cases where a component
    ///controls object delivery.
    ///Params:
    ///    uCount = Number of objects being requested.
    ///    pSink = Sink to receive the objects. The sink must be implemented by the caller. As each batch of objects is
    ///            requested, they are delivered to the <i>pSink</i> parameter of the Indicate method followed by a final call
    ///            to the <i>pSink</i>parameter of the SetStatus method. If the sink is going to be used to deliver objects,
    ///            this method returns <b>WBEM_S_NO_ERROR</b>, even if the number of objects to be delivered is less than
    ///            requested. However, if there are no more objects remaining, then the <i>pSink</i> parameter is ignored (no
    ///            calls to the <i>pSink</i>parameter of <b>SetStatus</b> are made). Instead, this method returns
    ///            <b>WBEM_S_FALSE</b>.
    ///Returns:
    ///    The <b>NextAsync</b> method returns an <b>HRESULT</b> that indicates the status of the method call. The
    ///    following list lists the value contained within an <b>HRESULT</b>.
    ///    
    HRESULT NextAsync(uint uCount, IWbemObjectSink pSink);
    ///The <b>IEnumWbemClassObject::Clone</b> method makes a logical copy of the entire enumerator, retaining its
    ///current position in an enumeration. This method makes only a "best effort" copy. Due to the dynamic nature of
    ///many CIM objects, it is possible that the new enumerator does not enumerate the same set of objects as the source
    ///enumerator. <div class="alert"><b>Note</b> <p class="note">When the enumeration is initialized with the
    ///<b>WBEM_FLAG_FORWARD_ONLY</b> flag, <b>IEnumWbemClassObject::Clone</b> is not supported. <p class="note">Any
    ///pending asynchronous deliveries begun by NextAsync are not cloned. </div><div> </div>
    ///Params:
    ///    ppEnum = Receives a pointer to a new IEnumWbemClassObject object. The caller must call Release when the interface
    ///             pointer is no longer required. On error, there will not be a return of a new object.
    ///Returns:
    ///    On error, you can call the COM function GetErrorInfo to obtain more error information. COM-specific error
    ///    codes may also be returned if network problems cause you to lose the remote connection to Windows Management.
    ///    The following list lists the value contained within an <b>HRESULT</b>.
    ///    
    HRESULT Clone(IEnumWbemClassObject* ppEnum);
    ///You can use the <b>IEnumWbemClassObject::Skip</b> method to move the current position in an enumeration ahead by
    ///a specified number of objects. Also, this affects subsequent calls to NextAsync, but it does not affect pending
    ///deliveries begun with <b>NextAsync</b>.
    ///Params:
    ///    lTimeout = Maximum amount of time in milliseconds that the call to <b>Skip</b> blocks before returning. If you use the
    ///               constant <b>WBEM_INFINITE</b> (0xFFFFFFFF), the call blocks until the operation succeeds. If <b>Skip</b>
    ///               cannot complete the operation before the <i>lTimeout</i> value expires, the call returns
    ///               <b>WBEM_S_TIMEDOUT</b>.
    ///    nCount = Number of objects to skip. If this parameter is greater than the number of objects left to enumerate, then
    ///             this call skips to the end of the enumeration and <b>WBEM_S_FALSE</b> is returned.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained within an <b>HRESULT</b>.
    ///    
    HRESULT Skip(int lTimeout, uint nCount);
}

///The <b>IWbemCallResult</b> interface is used for semisynchronous calls of the IWbemServices interface. When making
///such calls, the called <b>IWbemServices</b> method returns immediately, along with an <b>IWbemCallResult</b> object.
///Periodically, you can poll the returned <b>IWbemCallResult</b> object to determine the status of the call. You can
///obtain the result of the original IWbemServices call after it is complete by calling IWbemCallResult::GetCallStatus.
///This call-return paradigm is useful in cases where a thread cannot afford to be blocked for more than a few seconds
///because it is servicing other tasks, such as processing window messages. Not all IWbemServices methods support this
///interface because it is not required for all of them. The intent is to allow nonblocking, synchronous operation
///(semisynchronous operation) for all relevant operations. Because many of the <b>IWbemServices</b> methods are already
///nonblocking due to the use of enumerators or other constructs, only the following methods need this helper interface
///to support semisynchronous operation: <ul> <li> OpenNamespace </li> <li> GetObject </li> <li> PutInstance </li> <li>
///PutClass </li> <li> DeleteClass </li> <li> DeleteInstance </li> <li> ExecMethod </li> </ul>
@GUID("44ACA675-E8FC-11D0-A07C-00C04FB68820")
interface IWbemCallResult : IUnknown
{
    ///The <b>IWbemCallResult::GetResultObject</b> method attempts to retrieve an object from a previous semisynchronous
    ///call to IWbemServices::GetObject or IWbemServices::ExecMethod. If the object is not yet available, the call
    ///returns <b>WBEM_S_TIMEDOUT</b>. Also, before invoking this method to get the resulting object, you may call
    ///IWbemCallResult::GetCallStatus until it returns <b>WBEM_S_NO_ERROR</b>, indicating that the original
    ///semisynchronous operation is complete.
    ///Params:
    ///    lTimeout = Specifies the maximum time in milliseconds that this call blocks before returning. If you use the constant
    ///               <b>WBEM_INFINITE</b> (0xFFFFFFFF), the call blocks until the object is available. If you use 0, the call
    ///               immediately returns either the object or a status code.
    ///    ppResultObject = This parameter cannot be <b>NULL</b>. It receives the copy of the object when it becomes available. You must
    ///                     call <b>IWbemClassObject::Release</b> on the returned object when the object is no longer required. A new
    ///                     object is not returned on error.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained withinan <b>HRESULT</b>. If the original semisynchronous operation failed (such as when the
    ///    object was not found, or the method could not be invoked), this method returns the error code that the
    ///    original function would have returned in its synchronous version. On error, you can call the COM function
    ///    <b>GetErrorInfo</b> to obtain more error information. COM-specific error codes may also be returned if
    ///    network problems cause you to lose the remote connection to Windows Management.
    ///    
    HRESULT GetResultObject(int lTimeout, IWbemClassObject* ppResultObject);
    ///The <b>IWbemCallResult::GetResultString</b> method returns the assigned object path of an instance newly created
    ///by IWbemServices::PutInstance. <div class="alert"><b>Note</b> The call result object is primarily used when the
    ///PutInstance call is carried out by a provider and the client needs to know the object path (the values of the key
    ///properties) assigned the provider. For example, if the class key property is a globally unique identifier (GUID),
    ///assigned by the provider during the <b>PutInstance</b> operation, the client would have no way of knowing this
    ///GUID unless the provider was able to return it in this way.</div><div> </div>
    ///Params:
    ///    lTimeout = Specifies the maximum time in milliseconds that this call blocks before returning. If you use the constant
    ///               <b>WBEM_INFINITE</b> (0xFFFFFFFF), the call blocks until the object path is available. If you use 0, the call
    ///               immediately returns either the object path or a status code.
    ///    pstrResultString = Cannot be <b>NULL</b>. This parameter receives a pointer to the object path, which, in turn, leads to the
    ///                       newly created object. The returned string must be deallocated using the system call <i>SysFreeString</i>. On
    ///                       error, a new string is not returned.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained withinan <b>HRESULT</b>. On error, you can call the COM function <b>GetErrorInfo</b> to
    ///    obtain more error information. COM-specific error codes may also be returned if network problems cause you to
    ///    lose the remote connection to Windows Management.
    ///    
    HRESULT GetResultString(int lTimeout, BSTR* pstrResultString);
    ///The <b>IWbemCallResult::GetResultServices</b> method retrieves the IWbemServices pointer, which results from a
    ///semisynchronous call to IWbemServices::OpenNamespace when it becomes available.
    ///Params:
    ///    lTimeout = The maximum time in milliseconds that this call blocks before it returns. If you use the constant
    ///               <b>WBEM_INFINITE</b> (0xFFFFFFFF), the call blocks until the interface pointer is available. If you use 0,
    ///               the call immediately returns either the pointer or a status code.
    ///    ppServices = Cannot be <b>NULL</b>. It receives a pointer to the IWbemServices interface requested by the original call to
    ///                 OpenNamespace when it becomes available The caller must call IWbemServices::Releaseon the returned object
    ///                 when it is no longer required. On error, a new object is not returned.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> that indicates the status of the method call. The following list lists
    ///    the value contained within an <b>HRESULT</b>. On error, the COM function GetErrorInfo can be called to obtain
    ///    more error information. COM-specific error codes may also be returned if network problems cause you to lose
    ///    the remote connection to Windows Management.
    ///    
    HRESULT GetResultServices(int lTimeout, IWbemServices* ppServices);
    ///The <b>IWbemCallResult::GetCallStatus</b> method returns to the user the status of the current outstanding
    ///semisynchronous call. When this call returns <b>WBEM_S_NO_ERROR</b>, the original call to the IWbemServices
    ///method is complete.
    ///Params:
    ///    lTimeout = Specifies the maximum time in milliseconds that this call blocks before it returns. If you use the constant
    ///               <b>WBEM_INFINITE</b> (0xFFFFFFFF), the call blocks until the original semisynchronous call to an
    ///               IWbemServices method is complete. If you use 0 (zero), the call immediately returns the call status.
    ///    plStatus = If <b>WBEM_S_NO_ERROR</b> returns in the HRESULT to this method, this parameter will receive the final result
    ///               status of a call to one of the IWbemServices methods: OpenNamespace, PutInstance, PutClass, GetObject,
    ///               DeleteInstance, DeleteClass, or ExecMethod. On error, the value pointed to by <i>plStatus</i> will not be
    ///               used.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained withinan <b>HRESULT</b>.
    ///    
    HRESULT GetCallStatus(int lTimeout, int* plStatus);
}

///The <b>IWbemContext</b> interface is optionally used to communicate additional context information to providers when
///submitting IWbemServices calls to WMI. All primary calls in <b>IWbemServices</b> take an optional parameter pointing
///to an object of this type.
@GUID("44ACA674-E8FC-11D0-A07C-00C04FB68820")
interface IWbemContext : IUnknown
{
    ///The <b>IWbemContext::Clone</b> method makes a logical copy of the current IWbemContext object. This method can be
    ///useful when many calls must be made which have largely identical <b>IWbemContext</b> objects.
    ///Params:
    ///    ppNewCopy = Must point to <b>NULL</b> on entry. It receives a pointer to the new object containing the clone of the
    ///                current object. The returned pointer has a positive reference count. The caller must call
    ///                <b>IWbemServices::Release</b> on this pointer when it is no longer needed. On error, this pointer is left
    ///                unmodified, and a new object is not returned.
    HRESULT Clone(IWbemContext* ppNewCopy);
    ///The <b>IWbemContext::GetNames</b> method returns a <b>SAFEARRAY</b> structure of all of the names of the named
    ///context values. After all the names are known, GetValue can be called on each name to retrieve the value. This
    ///technique is a way of accessing the context values that is different from calling the BeginEnumeration, Next, and
    ///EndEnumeration methods.
    ///Params:
    ///    lFlags = Reserved. This parameter must be 0.
    ///    pNames = This parameter cannot be <b>NULL</b>, but on entry it must point to <b>NULL</b>. If no error is returned, on
    ///             exit <i>pstrNames</i> receives a pointer to a new <b>SAFEARRAY</b> structure of type VT_BSTR containing all
    ///             the context value names. The caller must call <b>SafeArrayDestroy</b> on the returned pointer when the array
    ///             is no longer required. If an error code is returned, the pointer is left unmodified. <div
    ///             class="alert"><b>Note</b> If there are no named values in the object, the call succeeds and returns an array
    ///             of length 0.</div> <div> </div>
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained within an <b>HRESULT</b>.
    ///    
    HRESULT GetNames(int lFlags, SAFEARRAY** pNames);
    ///The <b>IWbemContext::BeginEnumeration</b> method resets the enumeration of all the context values in the object.
    ///This method must be called before the first call to IWbemContext::Next to enumerate all of the context values in
    ///the object. The order in which context values are enumerated is guaranteed to be invariant for a given instance
    ///of IWbemContext.
    ///Params:
    ///    lFlags = Reserved. This parameter must be 0.
    ///Returns:
    ///    This method returns an <b>HRESULT</b>HRESULT indicating the status of the method call. The following list
    ///    lists the value contained withinan <b>HRESULT</b>HRESULT.
    ///    
    HRESULT BeginEnumeration(int lFlags);
    ///The <b>IWbemContext::Next</b> method retrieves the next value in an enumeration of all context values beginning
    ///with IWbemContext::BeginEnumeration.
    ///Params:
    ///    lFlags = Reserved. This parameter must be 0.
    ///    pstrName = This parameter cannot be <b>NULL</b>. The pointer must not point to an active <b>BSTR</b> on entry, and
    ///               ideally it should be set to point to <b>NULL</b>. If no error code is returned, it is set to point to a newly
    ///               allocated <b>BSTR</b> containing the context value name. The caller must call <b>SysFreeString</b> on the
    ///               returned string when it is no longer required. If <b>WBEM_S_NO_MORE_DATA</b> returns, <i>pstrName</i> is set
    ///               to point to <b>NULL</b>, in which case <b>SysFreeString</b> should not be called. Note that if
    ///               <i>pstrName</i> points to a valid <b>BSTR</b> on entry, this <b>BSTR</b> is not freed, and a memory leak
    ///               occurs.
    ///    pValue = This parameter cannot be <b>NULL</b>, and it must point to an empty or uninitialized <b>VARIANT</b>. If no
    ///             error is returned, the <b>VARIANT</b> is initialized using <b>VariantInit</b>, and then set to contain the
    ///             context value. The caller must call <b>VariantClear</b> on this pointer when the value is no longer required.
    ///             If an error code is returned, the <b>VARIANT</b> pointed to by <i>pValue</i> is left unmodified. If
    ///             <b>WBEM_S_NO_MORE_DATA</b> returns, this parameter is set to point to a <b>VARIANT</b> of type
    ///             <b>VT_NULL</b>. It is possible that an entire IWbemClassObject object may be returned inside the
    ///             <b>VARIANT</b>. If that is the case, then <b>VT_UNKNOWN</b> is the <b>VARIANT</b> type. The caller can take
    ///             the <b>IUnknown</b> pointer and execute <b>QueryInterface</b> to obtain the <b>IWbemClassObject</b> pointer.
    ///             <div class="alert"><b>Note</b> At the end of the enumeration, <b>WBEM_S_NO_MORE_DATA</b> is returned. The
    ///             returned <b>VARIANT</b> is of type <b>VT_NULL</b>, and the returned <i>pstrName</i> is <b>NULL</b>.</div>
    ///             <div> </div>
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained within an <b>HRESULT</b>.
    ///    
    HRESULT Next(int lFlags, BSTR* pstrName, VARIANT* pValue);
    ///The <b>IWbemContext::EndEnumeration</b> method ends an enumeration sequence that begins with
    ///IWbemContext::BeginEnumeration. This call is not required, but it releases as early as possible any system
    ///resources associated with the enumeration.
    ///Returns:
    ///    This method returns an <b>HRESULT</b>HRESULT indicating the status of the method call. The following list
    ///    lists the value contained withinan <b>HRESULT</b>HRESULT.
    ///    
    HRESULT EndEnumeration();
    ///The <b>IWbemContext::SetValue</b> method creates or overwrites a named context value.
    ///Params:
    ///    wszName = Cannot be <b>NULL</b>. It is a read-only pointer that indicates the context value name. This value must be
    ///              <b>null</b>-terminated.
    ///    lFlags = Reserved. This parameter must be 0 (zero).
    ///    pValue = Must point to a valid <b>VARIANT</b>, which is treated as read-only. The value in the <b>VARIANT</b> becomes
    ///             the named context value. An entire IWbemClassObject object can be stored as well as a simple value by
    ///             enclosing it in a <b>VARIANT</b> that uses the <b>VT_UNKNOWN</b> type. The caller must execute QueryInterface
    ///             on the <b>IWbemClassObject</b> object by asking for <b>IID_IUnknown</b>, and by using the returned pointer in
    ///             the <b>VARIANT</b>. If <i>pValue</i> is to contain an embedded IWbemClassObject object, the caller must call
    ///             IWbemClassObject::QueryInterface for <b>IID_IUnknown</b> and place the resulting pointer in the
    ///             <b>VARIANT</b> by using a type of <b>VT_UNKNOWN</b>. The original embedded object is copied during the write
    ///             operation, and so cannot be modified by the operation.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> that indicates the status of a method call. The following list lists
    ///    and describes the values contained in an <b>HRESULT</b>.
    ///    
    HRESULT SetValue(const(PWSTR) wszName, int lFlags, VARIANT* pValue);
    ///The <b>IWbemContext::GetValue</b> method is used to retrieve a specific named context value by name.
    ///Params:
    ///    wszName = Name for which the value is to be retrieved. This must point to a valid <b>BSTR</b>. The pointer is treated
    ///              as read-only.
    ///    lFlags = Reserved. This parameter must be 0.
    ///    pValue = This parameter cannot be <b>NULL</b> and must point to an uninitialized <b>VARIANT</b>. If no error is
    ///             returned, the <b>VARIANT</b> is initialized using <b>VariantInit</b>, and then set to contain the context
    ///             value. The caller must call <b>VariantClear</b> on this pointer when the value is no longer required. If an
    ///             error code is returned, the <b>VARIANT</b> pointed to by <i>pValue</i> is left unmodified. It is possible
    ///             that an entire IWbemClassObject object can be returned inside the <b>VARIANT</b>. If that is the case, then
    ///             <b>VT_UNKNOWN</b> is the <b>VARIANT</b> type. The caller can take the <b>IUnknown</b> pointer and execute
    ///             <b>QueryInterface</b> to obtain the <b>IWbemClassObject</b> pointer.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained within an <b>HRESULT</b>.
    ///    
    HRESULT GetValue(const(PWSTR) wszName, int lFlags, VARIANT* pValue);
    ///The <b>IWbemContext::DeleteValue</b> method deletes a named context value created by IWbemContext::SetValue.
    ///Params:
    ///    wszName = Pointer to a valid <b>BSTR</b> containing the named context value to delete. The pointer is treated as
    ///              read-only.
    ///    lFlags = Reserved. This parameter must be 0.
    ///Returns:
    ///    This method returns an <b>HRESULT</b>HRESULT indicating the status of the method call. The following list
    ///    lists the value contained withinan <b>HRESULT</b>HRESULT.
    ///    
    HRESULT DeleteValue(const(PWSTR) wszName, int lFlags);
    ///The <b>IWbemContext::DeleteAll</b> method removes all named context values from the current object, thus emptying
    ///the object.
    ///Returns:
    ///    This method returns an <b>HRESULT</b>HRESULT indicating the status of the method call. The following list
    ///    lists the value contained withinan <b>HRESULT</b>HRESULT.
    ///    
    HRESULT DeleteAll();
}

///The <b>IUnsecuredApartment</b> interface is used to simplify the process of making asynchronous calls from a client
///process. When a client is making asynchronous calls, the roles of the client and the server are reversed. In this
///case, the client implements an object (IWbemObjectSink interface) and the server calls the methods of that object.
///Because of this, COM security rules for servers make it difficult for clients to make asynchronous calls. The primary
///difficulty is the fact that the client needs to inform COM that it will allow Windows Management to invoke methods on
///the client's object (<b>IWbemObjectSink</b>).
@GUID("1CFABA8C-1523-11D1-AD79-00C04FD8FDFF")
interface IUnsecuredApartment : IUnknown
{
    ///The <b>CreateObjectStub</b> method creates an object forwarder sink to assist in receiving asynchronous calls
    ///from Windows Management. This function binds an unsecured object sink to a local object sink so that COM security
    ///does not interfere with asynchronous retrieval of CIM objects. Because COM security is being bypassed, the remote
    ///Windows Management server is assumed to be a trusted component. The general paradigm is that the original
    ///implementation of IWbemObjectSink in the client process is not directly used in asynchronous calls to
    ///IWbemServices. Rather, both the original implementation and a substitute object are created, bound together, and
    ///then the substitute object is used in the asynchronous methods of <b>IWbemServices</b>.
    ///Params:
    ///    pObject = Pointer to the client's in-process implementation of IWbemObjectSink.
    ///    ppStub = Receives a pointer to a substitute object to be used in asynchronous IWbemServices calls. The user receives
    ///             an IUnknown pointer and must call QueryInterface for <b>IID_WbemObjectSink</b> before using this object in
    ///             asynchronous <b>IWbemServices</b> calls.
    ///Returns:
    ///    This method returns standard COM error codes for QueryInterface. It returns <b>S_OK</b> if the call succeeds.
    ///    If the call fails because the requested interface was not supported, the method returns <b>E_NOINTERFACE</b>.
    ///    COM-specific error codes also may be returned if network problems cause you to lose the remote connection to
    ///    Windows Management.
    ///    
    HRESULT CreateObjectStub(IUnknown pObject, IUnknown* ppStub);
}

///The <b>IWbemUnsecuredApartment</b> interface allows client applications to determine whether Unsecapp.exe performs
///access checks on asynchronous callbacks. Unsecapp.exe supports both IUnsecuredApartment and
///<b>IWbemUnsecuredApartment</b> interfaces.
@GUID("31739D04-3471-4CF4-9A7C-57A44AE71956")
interface IWbemUnsecuredApartment : IUnsecuredApartment
{
    ///The CreateSinkStub method is similar to the <b>IUnsecuredApartment::CreateObjectStub</b> and creates an object
    ///forwarder sink and performs access checks for receiving asynchronous calls from Windows Management.
    ///<b>CreateSinkStub</b> differs from <b>CreateObjectStub</b> because it can specify that callbacks to the sink
    ///should be authenticated. WMI provides the Unsecapp.exe process to function as the separate process. You can host
    ///Unsecapp.exe with a call to the IWbemUnsecuredApartment interface or IUnsecuredApartment interface in other
    ///versions of Windows. <b>IUnsecuredApartment</b> does not have any methods that perform access checking. An access
    ///check means that Unsecapp.exe only allows the account of the computer that originally obtained the sink to invoke
    ///callbacks. When the registry key <b>UnsecAppAccessControlDefault</b> is set to zero then Unsecapp.exe does not
    ///perform access control on callbacks unless CreateSinkStub is called by an application with the <i>dwFlag</i>
    ///parameter set to <b>WBEM_FLAG_UNSECAPP_CHECK_ACCESS</b>. If the parameter is not present, which is the default,
    ///then Unsecapp.exe reads the registry key value to determine whether to authenticate callbacks.
    ///Params:
    ///    pSink = Pointer to the client's in-process implementation of IWbemObjectSink.
    ///    dwFlags = You can set one of the following values from WBEM_UNSECAPP_FLAG_TYPE enumeration. This parameter determines
    ///              how Unsecapp.exe uses the registry key checks this registry key: <b>HKEY_LOCAL_MACHINE</b>&
    ///    wszReserved = Reserved.
    ///    ppStub = Receives a pointer to a substitute object to be used in asynchronous IWbemServices calls. The user receives
    ///             an IUnknown pointer and must call QueryInterface for <b>IID_WbemObjectSink</b> before using this object in
    ///             asynchronous <b>IWbemServices</b> calls.
    ///Returns:
    ///    This method returns standard COM error codes for QueryInterface. It returns <b>S_OK</b> if the call succeeds.
    ///    If the call fails because the requested interface was not supported, the method returns <b>E_NOINTERFACE</b>.
    ///    COM-specific error codes also may be returned if network problems cause you to lose the remote connection to
    ///    Windows Management.
    ///    
    HRESULT CreateSinkStub(IWbemObjectSink pSink, uint dwFlags, const(PWSTR) wszReserved, IWbemObjectSink* ppStub);
}

///The <b>IWbemStatusCodeText</b> interface extracts text string descriptions of error codes or the name of the
///subsystem where the error occurred.
@GUID("EB87E1BC-3233-11D2-AEC9-00C04FB68820")
interface IWbemStatusCodeText : IUnknown
{
    ///The <b>IWbemStatusCodeText::GetErrorCodeText</b> method returns the text string description associated with the
    ///error code.
    ///Params:
    ///    hRes = Handle to the error code for which you want a description.
    ///    LocaleId = Reserved. This parameter must be 0 (zero).
    ///    lFlags = Reserved. This parameter must be 0 (zero).
    ///    MessageText = Pointer to a string containing the descriptive text of the error code.
    ///Returns:
    ///    This method returns <b>WBEM_S_NO_ERROR</b> if successful.
    ///    
    HRESULT GetErrorCodeText(HRESULT hRes, uint LocaleId, int lFlags, BSTR* MessageText);
    ///The <b>IWbemStatusCodeText::GetFacilityCodeText</b> method returns the name of the subsystem where the error
    ///occurred, such as "Windows", "WBEM", "SSPI", or "RPC".
    ///Params:
    ///    hRes = Handle to the error code for which you want a description.
    ///    LocaleId = Reserved. This parameter must be 0 (zero).
    ///    lFlags = Reserved. This parameter must be 0 (zero).
    ///    MessageText = Pointer to a string containing the descriptive text of the error code.
    ///Returns:
    ///    This method returns <b>WMI_S_NO_ERROR</b> if successful.
    ///    
    HRESULT GetFacilityCodeText(HRESULT hRes, uint LocaleId, int lFlags, BSTR* MessageText);
}

///The <b>IWbemBackupRestore</b> interface backs up and restores the contents of the WMI repository. The affected
///content of the repository is static data, such as the class definitions that are compiled into the repository when a
///MOF file is loaded. The dynamic data supplied through providers is not included.
@GUID("C49E32C7-BC8B-11D2-85D4-00105A1F8304")
interface IWbemBackupRestore : IUnknown
{
    ///The <b>IWbemBackupRestore::Backup</b> method backs up the contents of the static repository to a separate file.
    ///Params:
    ///    strBackupToFile = Constant, null-terminated string of 16-bit Unicode characters that contains the file name to which to back up
    ///                      the contents of the repository.
    ///    lFlags = Reserved. This parameter must be 0 (zero).
    HRESULT Backup(const(PWSTR) strBackupToFile, int lFlags);
    ///The <b>IWbemBackupRestore::Restore</b> method deletes the contents of the current repository and restores them
    ///with the contents of a previously specified backup. Because Windows Management Instrumentation (WMI) is the
    ///server for this interface and must be stopped to complete this operation successfully, the COM connection is
    ///broken if this call is successful.
    ///Params:
    ///    strRestoreFromFile = Constant, null-terminated string of 16-bit Unicode characters that contains the file name of the file to be
    ///                         restored. The specified file should point to a file previously created with IWbemBackupRestore::Backup.
    ///    lFlags = One of the following flags from the WBEM_BACKUP_RESTORE_FLAGS enumeration.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> that indicates the status of the method call. The following list lists
    ///    the value contained within the <b>HRESULT</b>.
    ///    
    HRESULT Restore(const(PWSTR) strRestoreFromFile, int lFlags);
}

///The <b>IWbemBackupRestoreEx</b> interface backs up and restores the contents of the repository. The affected content
///of the repository is static data, such as the class definitions that get compiled into the repository when a Managed
///Object Format (MOF) file is loaded. The dynamic data supplied through providers is not included. This interface adds
///the Pause and Resume methods to the functionality of IWbemBackupRestore.
@GUID("A359DEC5-E813-4834-8A2A-BA7F1D777D76")
interface IWbemBackupRestoreEx : IWbemBackupRestore
{
    ///The <b>IWbemBackupRestoreEx::Pause</b> method locks out write operations from the Windows Management
    ///Instrumentation (WMI) repository, and may cause read operations to be blocked.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> that indicates the status of a method call. The following list lists
    ///    the values contained within an <b>HRESULT</b>.
    ///    
    HRESULT Pause();
    ///The <b>IWbemBackUpRestoreEx::Resume</b> method releases a lock on the Windows Management Instrumentation (WMI)
    ///repository so operations can continue.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> that indicates the status of a method call. The following list lists
    ///    the values contained within an <b>HRESULT</b>.
    ///    
    HRESULT Resume();
}

///The <b>IWbemRefresher</b> interface provides an entry point through which refreshable objects such as enumerators or
///refresher objects, can be refreshed. Implementers of IWbemHiPerfProvider must provide an implementation of this
///interface. WMI supplies a client implementation of this interface. Clients can access this interface by calling
///CoCreateInstance on <b>CLSID_WbemRefresher</b>. This is the only supported implementation on the client.
@GUID("49353C99-516B-11D1-AEA6-00C04FB68820")
interface IWbemRefresher : IUnknown
{
    ///The <b>IWbemRefresher::Refresh</b> method updates all refreshable objects, enumerators, and nested refreshers.
    ///The WMI Refresher calls this function in response to a client request to <b>Refresh</b>.
    ///Params:
    ///    lFlags = Bitmask of flags that modify the behavior of this method. If <b>WBEM_FLAG_REFRESH_AUTO_RECONNECT</b> is
    ///             specified and if the connection is broken, the refresher attempts to reconnect to the provider automatically.
    ///             This is the default behavior for this method. If you do not want the refresher to attempt to reconnect to the
    ///             provider, specify <b>WBEM_FLAG_REFRESH_NO_AUTO_RECONNECT</b>.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained within an <b>HRESULT</b>.
    ///    
    HRESULT Refresh(int lFlags);
}

///The <b>IWbemHiPerfEnum</b> interface is used in refresher operations to provide rapid access to enumerations of
///instance objects. WMI provides an implementation of this interface, which it passes to providers when
///IWbemHiPerfProvider::CreateRefreshableEnum is called, and it returns to clients when IWbemConfigureRefresher::AddEnum
///is called. Client applications can call only the GetObjects method of this interface. Attempts by client applications
///to call the other <b>IWbemHiPerfEnum</b> methods return WBEM_E_ACCESS_DENIED. Providers call these other methods to
///update the enumerators whenever a client calls Refresh. <div class="alert"><b>Note</b> This interface is not
///implemented by the user or by a provider under any circumstances. The implementation provided by WMI is the only one
///supported.</div><div> </div>
@GUID("2705C288-79AE-11D2-B348-00105A1F8177")
interface IWbemHiPerfEnum : IUnknown
{
    ///The <b>IWbemHiPerfEnum::AddObjects</b> method adds the supplied instance objects to the enumerator.
    ///Params:
    ///    lFlags = Reserved. This parameter must be 0.
    ///    uNumObjects = Number of items in the object and the number of identifiers in the parameter.
    ///    apIds = Pointer to an array of integers that contains a unique identifier for each object in the object array.
    ///    apObj = Pointer to an array of instance objects to add to the enumerator.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained withinan <b>HRESULT</b>.
    ///    
    HRESULT AddObjects(int lFlags, uint uNumObjects, int* apIds, IWbemObjectAccess* apObj);
    ///The <b>IWbemHiPerfEnum::RemoveObjects</b> method removes objects (identified by their refresher identifiers) from
    ///a refresher.
    ///Params:
    ///    lFlags = Reserved. This parameter must be 0 (zero).
    ///    uNumObjects = Number of objects to remove.
    ///    apIds = Pointer to an array of integers that contains the refresher identifiers of the objects to remove.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained withinan <b>HRESULT</b>.
    ///    
    HRESULT RemoveObjects(int lFlags, uint uNumObjects, int* apIds);
    ///The <b>IWbemHiPerfEnum::GetObjects</b> method retrieves objects currently residing in the enumerator.
    ///Params:
    ///    lFlags = Integer that contains the flags.
    ///    uNumObjects = Size of the array passed to this method in the <i>apObj</i> parameter.
    ///    apObj = Pointer that holds the reference to an array of IWbemObjectAccess objects, which contains the returned
    ///            objects. The array must be big enough to hold all objects in the enumerator.
    ///    puReturned = Pointer to a <b>ULONG</b> used to return the number of objects placed in the array.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained within an <b>HRESULT</b>.
    ///    
    HRESULT GetObjects(int lFlags, uint uNumObjects, IWbemObjectAccess* apObj, uint* puReturned);
    ///The <b>IWbemHiPerfEnum::RemoveAll</b> method empties all objects from the enumerator.
    ///Params:
    ///    lFlags = Reserved. This parameter must be 0 (zero).
    HRESULT RemoveAll(int lFlags);
}

///The <b>IWbemConfigureRefresher</b> interface is used by client code to add enumerators, objects, and nested
///refreshers into a refresher. Users and providers should never implement this interface. The implementation provided
///by WMI is the only one that is supported. By providing a native implementation of this interface, WMI allows client
///code to easily configure refreshers. You can access the <b>IWbemConfigureRefresher</b> interface by calling
///QueryInterface on <b>IID_IWbemConfigureRefresher</b> on the object returned by calling CoCreateInstance on
///<b>CLSID_WbemRefresher</b>.
@GUID("49353C92-516B-11D1-AEA6-00C04FB68820")
interface IWbemConfigureRefresher : IUnknown
{
    ///The <b>IWbemConfigureRefresher::AddObjectByPath</b> method adds an object to a refresher by specifying an object
    ///path.
    ///Params:
    ///    pNamespace = An IWbemServices pointer back into Windows Management, which can service any request made by the provider.
    ///                 The provider should call AddRef on this pointer if it is going to call back into Windows Management during
    ///                 its execution.
    ///    wszPath = Constant, null-terminated string of 16-bit Unicode characters that contains the object path of the object you
    ///              add to the refresher.
    ///    lFlags = Bitmask of flags that modify the behavior of this method. If this parameter is set to
    ///             <b>WBEM_FLAG_USE_AMENDED_QUALIFIERS</b>, the returned instance contain localized qualifiers if available.
    ///    pContext = Typically <b>NULL</b>; otherwise, a pointer to an IWbemContext object that is required by one or more dynamic
    ///               class providers. The values in the context object must be specified in the specific provider documentation.
    ///               For more information about this parameter, see Making Calls to WMI.
    ///    ppRefreshable = Pointer to hold the reference to a IWbemClassObject object, which contains the refreshable instance object.
    ///                    The client must call Release on the returned object when it is no longer required.
    ///    plId = Pointer to an integer returned by the provider that uniquely identifies the refreshable object.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained within an <b>HRESULT</b>.
    ///    
    HRESULT AddObjectByPath(IWbemServices pNamespace, const(PWSTR) wszPath, int lFlags, IWbemContext pContext, 
                            IWbemClassObject* ppRefreshable, int* plId);
    ///With the <b>IWbemConfigureRefresher::AddObjectByTemplate</b> method, you can add an object you want refreshed to
    ///a refresher by specifying an IWbemClassObject instance template. Use this method when it is difficult to
    ///construct an object path for an object to add to a refresher. <div class="alert"><b>Note</b> The key properties
    ///of the instance object must be filled out before you can call the <b>AddObjectByTemplate</b> method.</div><div>
    ///</div>
    ///Params:
    ///    pNamespace = An IWbemServices pointer back into Windows Management, which can service any request made by the provider.
    ///                 The provider should call AddRef on this pointer if it is going to call back into Windows Management during
    ///                 its execution.
    ///    pTemplate = Pointer to a IWbemClassObject object that contains the instance template.
    ///    lFlags = Bitmask of flags that modify the behavior of this method. If this parameter is set to
    ///             <b>WBEM_FLAG_USE_AMENDED_QUALIFIERS</b>, the returned instance will contain localized qualifiers if
    ///             available.
    ///    pContext = Typically <b>NULL</b>; otherwise, a pointer to an IWbemContext object that is required by one or more dynamic
    ///               class providers. The values in the context object must be specified in the specific provider documentation.
    ///               For more information about this parameter, see Making Calls to WMI.
    ///    ppRefreshable = Pointer to hold the reference to a IWbemClassObject object, which will contain the refreshable instance
    ///                    object. The client must call Release on the returned object when it is no longer required.
    ///    plId = Pointer to an integer returned by the provider that uniquely identifies this refreshable object.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained within an <b>HRESULT</b>.
    ///    
    HRESULT AddObjectByTemplate(IWbemServices pNamespace, IWbemClassObject pTemplate, int lFlags, 
                                IWbemContext pContext, IWbemClassObject* ppRefreshable, int* plId);
    ///The <b>IWbemConfigureRefresher::AddRefresher</b> method adds a refresher to a refresher. The newly added
    ///refresher is called a "child refresher" or "nested refresher". You can use this method to create a single
    ///refresher containing more than one refresher that can be updated using a single call to the Refresh method.
    ///Params:
    ///    pRefresher = Pointer to a IWbemRefresher object to nest in this refresher.
    ///    lFlags = Reserved. This parameter must be 0 (zero).
    ///    plId = Pointer to an integer returned by the provider that uniquely identifies the refreshable object.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained within an <b>HRESULT</b>.
    ///    
    HRESULT AddRefresher(IWbemRefresher pRefresher, int lFlags, int* plId);
    ///The <b>IWbemConfigureRefresher::Remove</b> method is used to remove an object, enumerator, or nested refresher
    ///from a refresher.
    ///Params:
    ///    lId = Integer that uniquely identifies the object to remove. You obtain this identifier when you first add an
    ///          object to the refresher by calling IWbemConfigureRefresher::AddObjectByPath,
    ///          IWbemConfigureRefresher::AddObjectByTemplate, IWbemConfigureRefresher::AddEnum, or
    ///          IWbemConfigureRefresher::AddRefresher.
    ///    lFlags = Bitmask of flags that modify the behavior of the <b>Remove</b> method. If this parameter is set to.
    ///             <b>WBEM_FLAG_REFRESH_AUTO_RECONNECT</b>, the refresher attempts to automatically reconnect to a remote
    ///             provider if the connection is broken. This is default behavior for this method. Specify
    ///             <b>WBEM_FLAG_REFRESH_NO_AUTO_RECONNECT</b> if you do not want the refresher to attempt to reconnect to a
    ///             remote provider.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained within an <b>HRESULT</b>.
    ///    
    HRESULT Remove(int lId, int lFlags);
    ///The <b>IWbemConfigureRefresher::AddEnum</b> method adds an enumerator to the requested refresher.
    ///Params:
    ///    pNamespace = An IWbemServices pointer back into Windows Management, which can service any request made by the provider. If
    ///                 the method must call back into Windows Management during its execution, the provider should call AddRef with
    ///                 the <i>pNamespace</i> pointer.
    ///    wszClassName = Constant, null-terminated string of 16-bit Unicode characters containing the name of the class that is
    ///                   enumerated.
    ///    lFlags = Bitmask of flags that modify the behavior of this method. If this parameter is set to
    ///             WBEM_FLAG_USE_AMENDED_QUALIFIERS, the returned instances contain localized qualifiers if they are available.
    ///    pContext = Typically <b>NULL</b>; otherwise, this is a pointer to an IWbemContext object that is required by one or more
    ///               dynamic class providers. The values in the context object must be specified in the specific provider
    ///               documentation. For more information about this parameter, see Making Calls to WMI.
    ///    ppEnum = Pointer that holds the reference to a IWbemHiPerfEnum object, which will contain the enumeration. The client
    ///             must call Release on this pointer when it is no longer required.
    ///    plId = Pointer to an integer returned by the provider that uniquely identifies the refreshable enumeration.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained within an <div class="alert"><b>Note</b> <b>HRESULT</b></div> <div> </div>.
    ///    
    HRESULT AddEnum(IWbemServices pNamespace, const(PWSTR) wszClassName, int lFlags, IWbemContext pContext, 
                    IWbemHiPerfEnum* ppEnum, int* plId);
}

///Creates a sink interface that can receive all types of notifications within the WMI programming model. Clients must
///implement this interface to receive both the results of the asynchronous methods of IWbemServices, and specific types
///of event notifications. Providers use, but do not implement this interface to provide events and objects to WMI.
@GUID("E7D35CFA-348B-485E-B524-252725D697CA")
interface IWbemObjectSinkEx : IWbemObjectSink
{
    ///TBD
    ///Params:
    ///    uChannel = 
    ///    strMessage = 
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT WriteMessage(uint uChannel, const(BSTR) strMessage);
    ///TBD
    ///Params:
    ///    pObjError = 
    ///    puReturned = 
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT WriteError(IWbemClassObject pObjError, ubyte* puReturned);
    ///TBD
    ///Params:
    ///    strMessage = 
    ///    uPromptType = 
    ///    puReturned = 
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT PromptUser(const(BSTR) strMessage, ubyte uPromptType, ubyte* puReturned);
    ///TBD
    ///Params:
    ///    strActivity = 
    ///    strCurrentOperation = 
    ///    strStatusDescription = 
    ///    uPercentComplete = 
    ///    uSecondsRemaining = 
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT WriteProgress(const(BSTR) strActivity, const(BSTR) strCurrentOperation, 
                          const(BSTR) strStatusDescription, uint uPercentComplete, uint uSecondsRemaining);
    ///TBD
    ///Params:
    ///    strName = 
    ///    vtValue = 
    ///    ulType = 
    ///    ulFlags = 
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT WriteStreamParameter(const(BSTR) strName, VARIANT* vtValue, uint ulType, uint ulFlags);
}

///The <b>IWbemShutdown</b> interface indicates to the provider that an instance of an object is ready to be discarded.
///The provider can use this call to release resources that it is referencing currently. The interface is used by
///providers to receive notification that their object implementation is no longer required.
@GUID("B7B31DF9-D515-11D3-A11C-00105A1F515A")
interface IWbemShutdown : IUnknown
{
    ///The <b>IWbemShutdown::Shutdown</b> method indicates to the provider that the provider services are not required.
    ///Params:
    ///    uReason = Reserved. This value must be zero (0).
    ///    uMaxMilliseconds = Reserved. This value must be zero (0).
    ///    pCtx = Reserved. This value must be <b>NULL</b>.
    ///Returns:
    ///    This method returns an <b>HRESULT</b>, which identifies the status of the method call. The following list
    ///    lists the value contained within an <b>HRESULT</b>.
    ///    
    HRESULT Shutdown(int uReason, uint uMaxMilliseconds, IWbemContext pCtx);
}

///The <b>IWbemObjectTextSrc</b> interface is used to translate IWbemClassObject instances to and from differing text
///formats.
@GUID("BFBF883A-CAD7-11D3-A11B-00105A1F515A")
interface IWbemObjectTextSrc : IUnknown
{
    ///The <b>IWbemObjectTextSrc::GetText</b> method creates a textual representation of an IWbemClassObject object; for
    ///example, an XML representation.
    ///Params:
    ///    lFlags = Reserved. Must be 0L.
    ///    pObj = Reference to the object to be represented in text format. This parameter cannot be <b>NULL</b>.
    ///    uObjTextFormat = Definition of the text format used to represent the object. For more information about valid values for this
    ///                     parameter, see Remarks.
    ///    pCtx = Optional. Context object for the operation. The context object can be used to specify whether certain parts
    ///           of the object are represented in text; for example, whether to include qualifiers in the textual
    ///           representation. The context object takes the following optional values.
    ///    strText = Textual representation of the object. User must free the string using SysFreeString when finished with
    ///              <i>strText</i>.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> that indicates the status of the method call. The following list lists
    ///    the value contained within an <b>HRESULT</b>.
    ///    
    HRESULT GetText(int lFlags, IWbemClassObject pObj, uint uObjTextFormat, IWbemContext pCtx, BSTR* strText);
    HRESULT CreateFromText(int lFlags, BSTR strText, uint uObjTextFormat, IWbemContext pCtx, 
                           IWbemClassObject* pNewObj);
}

///The <b>IMofCompiler</b> interface, implemented by Mofd.dll, provides a COM interface that is used by the Managed
///Object Format (MOF) compiler and any other applications that compile MOF files. Objects defined as classes in the MOF
///files can be obtained using the <b>CLSID_MofCompiler</b> CLSID value.
@GUID("6DAF974E-2E37-11D2-AEC9-00C04FB68820")
interface IMofCompiler : IUnknown
{
    ///The <b>IMofCompiler::CompileFile</b> method compiles a MOF file (including binary MOFs) and stores the
    ///information in the WMI repository. This method performs the same operation as the Mofcomp command.
    ///Params:
    ///    FileName = The name of the file to be compiled.
    ///    ServerAndNamespace = The path to the default namespace where any classes or instance are written. You can specify a namespace on a
    ///                         remote computer ("\\computer\root", for example). This value can be overridden by the <b>
    ///    User = A value that specifies the credentials used to compile on remote computers. If the value is <b>NULL</b>, the
    ///           user context is whatever the calling process is using. This is always ignored when connecting to the local
    ///           computer. For more information, see the Remarks section.
    ///    Authority = A value that specifies the credentials for compiling on remote computers. If the value is <b>NULL</b>, the
    ///                authority context is whatever the calling process is using. This is always ignored when connecting to the
    ///                local computer. For more information, see the Remarks section.
    ///    Password = A value that specifies the credentials for compiling on remote computers. If the value is <b>NULL</b>, the
    ///               password of the current context is used. This is always ignored when connecting to the local computer.
    ///    lOptionFlags = A parameter that, when the <b>CompileFile</b> method is used, enables the combination of one or more of the
    ///                   following flags.
    ///    lClassFlags = The flags that control the creation of classes. Parameters may be 0 or a combination of the following values.
    ///    lInstanceFlags = The flags that control the creation of instances. Parameter values can be either 0 or one of the following
    ///                     flags.
    ///    pInfo = Pointer to a WBEM_COMPILE_STATUS_INFO that describes an error. If the parameter value is not <b>NULL</b>, an
    ///            error has occurred, and the structure is filled with error information.
    ///Returns:
    ///    This method can return one of these values. 2 Warning that #pragma autorecover statement is not present. This
    ///    statement should be one the first line of the MOF file.
    ///    
    HRESULT CompileFile(PWSTR FileName, PWSTR ServerAndNamespace, PWSTR User, PWSTR Authority, PWSTR Password, 
                        int lOptionFlags, int lClassFlags, int lInstanceFlags, WBEM_COMPILE_STATUS_INFO* pInfo);
    ///The <b>IMofCompiler::CompileBuffer</b> method compiles either a buffer containing binary MOF data or a text
    ///buffer in ASCII format. Binary MOF files contain parsed data and must be stored in the database. The
    ///<b>CompileBuffer</b> method only accepts multi-byte character arrays (string buffers) that are not
    ///<b>NULL</b>-terminated.
    ///Params:
    ///    BuffSize = Size of the data pointed to by the <i>pBuffer</i> parameter.
    ///    pBuffer = Pointer to the binary MOF file data or a text buffer in ASCII format.
    ///    ServerAndNamespace = Name of the server and namespace. This parameter is ignored unless the <i>pBuffer</i> parameter points to a
    ///                         text buffer. If the text MOF is passed without a <a href="/windows/desktop/WmiSdk/-pragma">
    ///    User = Name of the user requesting the service. This parameter specifies the credentials for compiling on remote
    ///           computers. If the value is <b>NULL</b>, then the user context is whatever the current process is using. This
    ///           is always ignored when connecting to the local computer. For more information, see the Remarks section.
    ///    Authority = Specifies the credentials for compiling on remote computers. If the value is <b>NULL</b>, the authority
    ///                context is whatever the current process is using. This parameter is always ignored when connecting to the
    ///                local computer. For more information, see the Remarks section.
    ///    Password = Specifies the credentials for compiling on remote computers. If the value is <b>NULL</b>, the password of the
    ///               current context is used. This parameter is always ignored when connecting to the local computer.
    ///    lOptionFlags = You can combine one or more of the following flags.
    ///    lClassFlags = This parameter is ignored because the binary MOF file already contains the information. The parameter value
    ///                  should be 0.
    ///    lInstanceFlags = Ignored because the binary MOF file already contains the information. The parameter value should be 0.
    ///    pInfo = Pointer to a WBEM_COMPILE_STATUS_INFO that describes an error. If the parameter value is not <b>NULL</b>, an
    ///            error has occurred, and the structure is filled with error information.
    ///Returns:
    ///    This method returns <b>WBEM_S_NO_ERROR</b> if successful. If the method is unsuccessful, it returns
    ///    <b>WBEM_S_FALSE</b>.
    ///    
    HRESULT CompileBuffer(int BuffSize, ubyte* pBuffer, PWSTR ServerAndNamespace, PWSTR User, PWSTR Authority, 
                          PWSTR Password, int lOptionFlags, int lClassFlags, int lInstanceFlags, 
                          WBEM_COMPILE_STATUS_INFO* pInfo);
    ///The <b>IMofCompiler::CreateBMOF</b> method creates a binary MOF file. File creation is accomplished by parsing a
    ///regular MOF file and storing a binary representation of the classes and instances into a special file format.
    ///Typically, this data binary large object (BLOB) is stored as a resource in an executable file, which can later be
    ///extracted for a call to the CompileBuffer method. The <b>IMofCompiler::CreateBMOF</b> can also be used to create
    ///a localized MOF file (.mfl).
    ///Params:
    ///    TextFileName = The name of the text file to be parsed.
    ///    BMOFFileName = <b>Binary MOF file: </b>The name of the file in which the resulting binary MOF data is to be stored.
    ///                   <b>Localized MOF file: </b>The <i>BMOFFileName</i> string must contain the following comma-separated values:
    ///                   <ul> <li> a&lt;locale&gt; Specifies the locale information. This value must start with a preceding comma. For
    ///                   more information, see the description of the <b>-ADMENDMENT</b> switch for the mofcomp utility. </li> <li>
    ///                   n&lt;filename.mof&gt; The name of the file in which the resulting binary MOF data is to be stored. </li> <li>
    ///                   l&lt;filename.mfl&gt; The name of the file in which the resulting localized MOF data is to be stored. </li>
    ///                   </ul> For example, <i>BMOFFileName</i>=",aMS_409,nmyFile.mof,lmyFile.mfl".
    ///    ServerAndNamespace = The path of the default namespace, where classes or instances are written. You can use this parameter to
    ///                         specify a namespace on a remote computer ("\\computer\root", for example). This value may be overridden by
    ///                         the <a href="/windows/desktop/WmiSdk/-pragma">
    ///    lOptionFlags = You can combine one or more of the following flags.
    ///    lClassFlags = The flags that control the creation of classes. The parameter value may be 0 or a combination of the
    ///                  following flags.
    ///    lInstanceFlags = Flags controlling the creation of instances. The parameter value may be either 0 or one of the following
    ///                     flags.
    ///    pInfo = Pointer to a WBEM_COMPILE_STATUS_INFO that describes an error. If the parameter value is not <b>NULL</b>, an
    ///            error has occurred, and the structure is filled with error information.
    ///Returns:
    ///    This method returns <b>WBEM_S_NO_ERROR</b> if successful. If the method is unsuccessful, it returns
    ///    <b>WBEM_S_FALSE</b>.
    ///    
    HRESULT CreateBMOF(PWSTR TextFileName, PWSTR BMOFFileName, PWSTR ServerAndNamespace, int lOptionFlags, 
                       int lClassFlags, int lInstanceFlags, WBEM_COMPILE_STATUS_INFO* pInfo);
}

///The <b>IWbemPropertyProvider</b> interface supports retrieving and updating individual properties in an instance of a
///WMI class.<b>IWbemPropertyProvider</b> is the primary interface of property providers that supply dynamic data, which
///is the majority of property providers. WMI is the only client of this interface, and it calls the methods whenever
///the properties are required by a client application of WMI.
@GUID("CE61E841-65BC-11D0-B6BD-00AA003240C7")
interface IWbemPropertyProvider : IUnknown
{
    ///The <b>IWbemPropertyProvider::GetProperty</b> method is called by Windows Management to retrieve an individual
    ///property value.
    ///Params:
    ///    lFlags = Reserved. This parameter must be 0.
    ///    strLocale = String indicating the desired locale in cases where the returned property value can be localized. If the
    ///                property cannot be localized, the implementation can ignore this value.
    ///    strClassMapping = Literal copy of the string value for the <b>ClassContext</b> qualifier for the class. This points to a valid
    ///                      <b>BSTR</b>, which is treated as read-only, or <b>NULL</b> if the qualifier does not exist.
    ///    strInstMapping = Literal copy of the string value for the <b>InstanceContext</b> qualifier for the instance. This must point
    ///                     to a valid <b>BSTR</b>, which is treated as read-only, or <b>NULL</b> if the qualifier does not exist.
    ///    strPropMapping = Literal copy of the value of the <b>PropertyContext</b> qualifier for the property. This must point to a
    ///                     valid <b>BSTR</b>, which is treated as read-only, or <b>NULL</b> if the qualifier does not exist.
    ///    pvValue = Pointer to an uninitialized <b>VARIANT</b> that receives the value for the property. The implementation must
    ///              call <b>VariantInit</b> and return the value. If an error occurs, the implementation is expected to ignore
    ///              the pointer.
    ///Returns:
    ///    This method must return <b>WBEM_S_NO_ERROR</b> if the call succeeds. If the call fails, the method must
    ///    return <b>WBEM_S_FALSE</b>.
    ///    
    HRESULT GetProperty(int lFlags, const(BSTR) strLocale, const(BSTR) strClassMapping, const(BSTR) strInstMapping, 
                        const(BSTR) strPropMapping, VARIANT* pvValue);
    ///The <b>IWbemPropertyProvider::PutProperty</b> method is called by Windows Management to update a property value
    ///supported by a property provider.
    ///Params:
    ///    lFlags = Reserved. This parameter must be 0.
    ///    strLocale = String indicating the desired locale in cases where the returned property value can be localized. If the
    ///                property cannot be localized, the implementation can ignore this value.
    ///    strClassMapping = Literal copy of the string value for the <b>ClassContext</b> qualifier for the class. This points to a valid
    ///                      <b>BSTR</b>, which is treated as read-only, or <b>NULL</b> if the qualifier does not exist.
    ///    strInstMapping = Literal copy of the string value for the <b>InstanceContext</b> qualifier for the instance. This must point
    ///                     to a valid <b>BSTR</b>, which is treated as read-only, or <b>NULL</b> if the qualifier does not exist.
    ///    strPropMapping = Literal copy of the value of the <b>PropertyContext</b> qualifier for the property. This must point to a
    ///                     valid <b>BSTR</b>, which is treated as read-only, or <b>NULL</b> if the qualifier does not exist.
    ///    pvValue = Pointer to an existing <b>VARIANT</b> that contains the value to be written.
    ///Returns:
    ///    This method must return <b>WBEM_S_NO_ERROR</b> if the operation succeeds, or <b>WBEM_S_FALSE</b> if the
    ///    operation fails.
    ///    
    HRESULT PutProperty(int lFlags, const(BSTR) strLocale, const(BSTR) strClassMapping, const(BSTR) strInstMapping, 
                        const(BSTR) strPropMapping, const(VARIANT)* pvValue);
}

///The <b>IWbemUnboundObjectSink</b> interface is implemented by all logical event consumers. It is a simple sink
///interface that accepts delivery of event objects.
@GUID("E246107B-B06E-11D0-AD61-00C04FD8FDFF")
interface IWbemUnboundObjectSink : IUnknown
{
    ///The <b>IWbemUnboundObjectSink::IndicateToConsumer</b> method is called by WMI to actually deliver events to a
    ///consumer. From an implementation standpoint, <b>IndicateToConsumer</b> contains the code for processing events
    ///that the sink receives.
    ///Params:
    ///    pLogicalConsumer = Pointer to the logical consumer object for which this set of objects is delivered.
    ///    lNumObjects = Number of objects delivered in the array that follows.
    ///    apObjects = Pointer to an array of IWbemClassObject instances which represent the events delivered. Because each object
    ///                in the array corresponds to a separate event, an implementation of <b>IndicateToConsumer</b> must treat each
    ///                object separately.
    ///Returns:
    ///    This method returns <b>WBEM_S_NO_ERROR</b> if successful. Otherwise, the implementation should return an
    ///    appropriate error code.
    ///    
    HRESULT IndicateToConsumer(IWbemClassObject pLogicalConsumer, int lNumObjects, IWbemClassObject* apObjects);
}

///Use the <b>IWbemEventProvider</b> interface to initiate communication with an event provider. Windows Management
///calls the provider's implementation of this interface when a consumer has indicated interest in receiving events
///generated by the provider.
@GUID("E245105B-B06E-11D0-AD61-00C04FD8FDFF")
interface IWbemEventProvider : IUnknown
{
    ///Windows Management calls the <b>IWbemEventProvider::ProvideEvents</b> method to signal an event provider to begin
    ///delivery of its events.
    ///Params:
    ///    pSink = Pointer to the object sink to which the provider will deliver its events. In an event provider
    ///            implementation, you should use the IWbemObjectSink::Indicate method to send events through <i>pSink</i>. This
    ///            is in contrast to other providers that may use the SetStatus method: The <b>ProvideEvents</b> method should
    ///            use only <b>Indicate</b> to update a sink.
    ///    lFlags = Reserved. This parameter must be 0.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained withinan <b>HRESULT</b>.
    ///    
    HRESULT ProvideEvents(IWbemObjectSink pSink, int lFlags);
}

///The <b>IWbemEventProviderQuerySink</b> interface is optionally implemented by event providers who want to know what
///kinds of event query filters are currently active to optimize performance.
@GUID("580ACAF8-FA1C-11D0-AD72-00C04FD8FDFF")
interface IWbemEventProviderQuerySink : IUnknown
{
    ///Call the <b>IWbemEventProviderQuerySink::NewQuery</b> method when a logical event consumer registers a relevant
    ///event query filter with Windows Management. The <b>NewQuery</b> method determines how a provider responds to a
    ///new query registered by a client application. When WMI receives a new or modified event query from a consumer,
    ///WMI calls <b>NewQuery</b> to echo the query to the event provider. The provider then generates the requested
    ///notification.
    ///Params:
    ///    dwId = Windows Management-generated identifier for the query. The provider can track this so that during a later
    ///           call to CancelQuery so that the provider will know which query was canceled.
    ///    wszQueryLanguage = Language of the following query filter. For this version of WMI, it will always be "WQL".
    ///    wszQuery = Text of the event query filter, which was registered by a logical consumer. The event provider can examine
    ///               the text of the query filter through the <i>wszQuery</i> parameter and the language of the query filter in
    ///               the <i>wszQueryLanguage</i> parameter to discover which event notifications the consumer is requesting.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists
    ///    return codes returned by <b>NewQuery</b>. Additionally, a third-party event provider could return any valid
    ///    WMI or COM return code which could be passed through <b>NewQuery</b> as a return value.
    ///    
    HRESULT NewQuery(uint dwId, ushort* wszQueryLanguage, ushort* wszQuery);
    ///Call the <b>IWbemEventProviderQuerySink::CancelQuery</b> method whenever a logical event consumer cancels a
    ///relevant event query filter with Windows Management. The <b>CancelQuery</b> method determines how an event
    ///provider responds to a relevant canceled event query filter. Whenever WMI retrieves a cancellation notice for an
    ///event query filter from a consumer, WMI calls <b>CancelQuery</b> to echo the cancellation to the responsible
    ///event provider. The event provider can examine the identifier of the query to determine which query is being
    ///canceled. The provider then modifies which events are being sent out based on the cancellation.
    ///Params:
    ///    dwId = Identifier of the query which was canceled. This identifier was originally delivered to the provider by the
    ///           NewQuery method of this interface.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained withinan <b>HRESULT</b>.
    ///    
    HRESULT CancelQuery(uint dwId);
}

///The <b>IWbemEventProviderSecurity</b> interface is optionally implemented by event providers who want to restrict
///consumer access to their event. For more information about when to use this interface, see Securing WMI Events.
@GUID("631F7D96-D993-11D2-B339-00105A1F4AAF")
interface IWbemEventProviderSecurity : IUnknown
{
    ///The <b>AccessCheck</b> method is implemented by an event provider and called by Windows Management
    ///Instrumentation (WMI) when a consumer subscribes to an event specified in <i>wszQuery</i>. A consumer that has
    ///access permission for an event can subscribe to that event. A consumer that does not have access permission for
    ///an event cannot subscribe to that event. For more information, see Writing an Event Provider and Securing WMI
    ///Events. For a temporary consumer, WMI sets the PSID supplied in the <i>pSid</i> parameter to <b>NULL</b> and the
    ///call is made by impersonating the consumer. For a permanent consumer, WMI sets the PSID with the security
    ///identifier (SID) of the user who created the subscription.
    ///Params:
    ///    wszQueryLanguage = Language of the following query filter, which is "WQL".
    ///    wszQuery = Text of the event query filter, which is registered by a logical consumer.
    ///    lSidLength = Integer that contains the security identifier (SID) length, or 0 (zero) if the subscription builder token is
    ///                 available.
    ///    pSid = Pointer to the constant byte integer type that contains the SID, or <b>NULL</b> if the subscription builder's
    ///           token is available.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> that indicates the status of the method call. The following list lists
    ///    the value contained in an <b>HRESULT</b>.
    ///    
    HRESULT AccessCheck(ushort* wszQueryLanguage, ushort* wszQuery, int lSidLength, const(ubyte)* pSid);
}

///The <b>IWbemEventConsumerProvider</b> interface provides the primary interface for an event consumer provider.
///Through this interface and the FindConsumer method, an event consumer provider can indicate which event consumers
///should receive a given event. The first time WMI delivers an event to a particular consumer, WMI calls FindConsumer
///to retrieve a pointer to the sink for that physical consumer. WMI then sends all subsequent occurrences of the event
///the sink provided by <b>FindConsumer</b>. If you implement a permanent event consumer, you must implement
///<b>IWbemEventConsumerProvider</b> so that WMI can deliver events to your physical consumer.
@GUID("E246107A-B06E-11D0-AD61-00C04FD8FDFF")
interface IWbemEventConsumerProvider : IUnknown
{
    ///The <b>FindConsumer</b> function locates and returns sink objects to which WMI can send events. WMI passes in a
    ///pointer to a logical consumer object, then <b>FindConsumer</b> locates the physical consumer associated with the
    ///logical consumer. Finally, <b>FindConsumer</b> returns to WMI a pointer to the sink belonging to the physical
    ///consumer. WMI calls AddRef on the sink and begins to deliver the appropriate events to the sink. WMI releases the
    ///sink after a configurable period of time with no deliveries. If necessary, WMI can call <b>FindConsumer</b> again
    ///to load the sink again.
    ///Params:
    ///    pLogicalConsumer = Pointer to the logical consumer object to which the event objects are to be delivered.
    ///    ppConsumer = Returns an event object sink to Windows Management. Windows Management calls AddRef for this pointer and
    ///                 deliver the events associated with the logical consumer to this sink. Eventually, after a suitable time-out,
    ///                 Windows Management calls Release for the pointer.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> that indicates the status of the method call. The following list lists
    ///    the value contained within an <b>HRESULT</b>.
    ///    
    HRESULT FindConsumer(IWbemClassObject pLogicalConsumer, IWbemUnboundObjectSink* ppConsumer);
}

///The <b>IWbemProviderInitSink</b> interface is implemented by WMI and called by providers to report initialization
///status.
@GUID("1BE41571-91DD-11D1-AEB2-00C04FB68820")
interface IWbemProviderInitSink : IUnknown
{
    ///The <b>IWbemProviderInitSink::SetStatus</b> method indicates to Windows Management whether a provider is fully or
    ///partially initialized.
    ///Params:
    ///    lStatus = Indicates to Windows Management a provider's initialization status. One of the following values can be set.
    ///    lFlags = Reserved. This parameter must be 0 (zero).
    ///Returns:
    ///    This method always returns <b>WBEM_S_NO_ERROR</b>.
    ///    
    HRESULT SetStatus(int lStatus, int lFlags);
}

///The <b>IWbemProviderInit</b> interface is called by Windows Management to initialize providers. All providers are
///required to implement <b>IWbemProviderInit</b>.
@GUID("1BE41572-91DD-11D1-AEB2-00C04FB68820")
interface IWbemProviderInit : IUnknown
{
    ///The <b>IWbemProviderInit::Initialize</b> method is called by Windows Management to initialize a provider to
    ///receive client requests. All types of providers must implement this method.
    ///Params:
    ///    wszUser = A pointer to the user name, if per-user initialization was requested in the __Win32Provider registration
    ///              instance for this provider. Otherwise, this is <b>NULL</b>. Be aware that this parameter is set to
    ///              <b>NULL</b> for event consumer providers regardless of the value of the <b>PerUserInitialization</b> property
    ///              in the __Win32Provider instance for the provider.
    ///    lFlags = Reserved. This parameter must be 0 (zero).
    ///    wszNamespace = A namespace name for which the provider is initialized.
    ///    wszLocale = Locale name for which the provider is being initialized. A string of the following format, where the hex
    ///                value is a Microsoft standard LCID value: <ul> <li>"MS_409"</li> </ul> This parameter may be <b>NULL</b>.
    ///    pNamespace = An IWbemServices pointer back into Windows Management. This pointer is can service any requests made by the
    ///                 provider. The provider should use the IWbemProviderInit::AddRef method on this pointer if it is going to call
    ///                 back into Windows Management during its execution.
    ///    pCtx = An IWbemContext pointer associated with initialization. This parameter may be <b>NULL</b>. If the provider
    ///           will perform requests back into Windows Management before completing initialization, it should use the
    ///           IWbemProviderInit::AddRef method on this pointer. For more information, see Making Calls to WMI. In the event
    ///           that a provider must make a dependent request on another provider, you must pass this context string back to
    ///           WMI to avoid potential lockups. However, in the case of an independent request, this is not necessary, and
    ///           WMI generates a new context string for it.
    ///    pInitSink = An IWbemProviderInitSink pointer that is used by the provider to report initialization status.
    ///Returns:
    ///    The provider should return <b>WBEM_S_NO_ERROR</b> and indicate its status using the supplied object sink in
    ///    the <i>pInitSink</i> parameter. However, if a provider returns <b>WBEM_E_FAILED</b> and does not use the
    ///    sink, then the provider initialization is considered as failed.
    ///    
    HRESULT Initialize(PWSTR wszUser, int lFlags, PWSTR wszNamespace, PWSTR wszLocale, IWbemServices pNamespace, 
                       IWbemContext pCtx, IWbemProviderInitSink pInitSink);
}

///The <b>IWbemHiPerfProvider</b> interface enables providers to supply refreshable objects and enumerators.
///High-performance providers can be loaded in-process to either WMI or a client process. When the provider is loaded
///in-process to a client process, it uses the CLSID specified as the <b>ClientLoadableCLSID</b> value in the
///__Win32Provider representing the provider instance definition.
@GUID("49353C93-516B-11D1-AEA6-00C04FB68820")
interface IWbemHiPerfProvider : IUnknown
{
    ///The <b>IWbemHiPerfProvider::QueryInstances</b> method returns instances of the specified class using the supplied
    ///IWbemObjectSink instance. The method should return immediately. The IWbemObjectSink interface is used to specify
    ///results. <div class="alert"><b>Note</b> If a provider does not implement this method, it must return
    ///<b>WBEM_E_PROVIDER_NOT_CAPABLE</b>.</div><div> </div>
    ///Params:
    ///    pNamespace = An IWbemServices pointer back to WMI that can service any request from the provider. The provider should call
    ///                 AddRef on this pointer if it needs to call back to WMI during execution.
    ///    wszClass = Pointer to a <b>WCHAR</b> string that specifies the class whose instances are returned.
    ///    lFlags = Integer that contains the flags.
    ///    pCtx = Typically <b>NULL</b>; otherwise, a pointer to an IWbemContext object that is required by one or more dynamic
    ///           class providers. The values in the context object must be specified in the provider documentation. For more
    ///           information, see Making Calls to WMI.
    ///    pSink = Pointer to the IWbemObjectSink implementation that is provided by the client to any of the asynchronous
    ///            methods of IWbemServices.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> that indicates the status of the method call. The following list lists
    ///    the value contained within an <b>HRESULT</b>. HiPerf providers can report success or failure either through
    ///    the return code from <b>QueryInstances</b> or through a call to the SetStatus method of
    ///    <i>pResponseHandler</i>. If you call the <b>SetStatus</b> method, the return code sent through
    ///    <i>pResponseHandler</i> takes precedence over the <b>QueryInstances</b> return code.
    ///    
    HRESULT QueryInstances(IWbemServices pNamespace, PWSTR wszClass, int lFlags, IWbemContext pCtx, 
                           IWbemObjectSink pSink);
    ///The <b>IWbemHiPerfProvider::CreateRefresher</b> method creates a refresher. The returned refresher will be used
    ///in subsequent calls to IWbemHiPerfProvider::CreateRefreshableEnum, IWbemHiPerfProvider::CreateRefreshableObject,
    ///and IWbemHiPerfProvider::StopRefreshing. <div class="alert"><b>Note</b> If a provider does not implement this
    ///method, it must return <b>WBEM_E_PROVIDER_NOT_CAPABLE</b>. A provider must implement this method to support
    ///refresher operations.</div><div> </div>
    ///Params:
    ///    pNamespace = An IWbemServices pointer back into Windows Management, which can service any request made by the provider.
    ///                 The provider should call AddRef on this pointer if it is going to call back into Windows Management during
    ///                 its execution.
    ///    lFlags = Reserved. This parameter must be 0 (zero).
    ///    ppRefresher = Pointer to hold the reference to the provider's implementation of the IWbemRefresher interface.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained within an <b>HRESULT</b>.
    ///    
    HRESULT CreateRefresher(IWbemServices pNamespace, int lFlags, IWbemRefresher* ppRefresher);
    ///The <b>IWbemHiPerfProvider::CreateRefreshableObject</b> method requests a refreshable instance object. The WMI
    ///Refresher calls <b>IWbemHiPerfProvider::CreateRefreshableObject</b> in response to a client request to the
    ///IWbemConfigureRefresher::AddObjectByPath or IWbemConfigureRefresher::AddObjectByTemplate interfaces. The provider
    ///reads the key from the supplied template object and supplies an object in the <i>ppRefreshable</i> parameter that
    ///will be refreshed whenever the refresh method on <i>pRefresher</i> is called. The provider associates the
    ///refreshable object with the supplied refresher, obtained from an earlier call to
    ///IWbemHiPerfProvider::CreateRefresher. <div class="alert"><b>Note</b> If a provider does not implement this
    ///method, it must return <b>WBEM_E_PROVIDER_NOT_CAPABLE</b>.</div><div> </div>
    ///Params:
    ///    pNamespace = An IWbemServices pointer back into Windows Management, which can service any request made by the provider. If
    ///                 the pointer must call back into WMI during its execution, the provider calls AddRef on it.
    ///    pTemplate = Pointer to a IWbemObjectAccess object that contains the template.
    ///    pRefresher = Pointer to a IWbemRefresher object that contains a refresher obtained by calling
    ///                 IWbemHiPerfProvider::CreateRefresher.
    ///    lFlags = Reserved. This parameter must be 0.
    ///    pContext = Typically <b>NULL</b>; otherwise, a pointer to an IWbemContext object that is required by one or more dynamic
    ///               class providers. The values in the context object must be specified in the specific provider documentation.
    ///               For more information about this parameter, see Making Calls to WMI.
    ///    ppRefreshable = Pointer that holds the reference to a IWbemObjectAccess object, which will contain the refreshable object.
    ///    plId = Pointer to an integer returned by the provider that uniquely identifies this refreshable object.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained within an <b>HRESULT</b>.
    ///    
    HRESULT CreateRefreshableObject(IWbemServices pNamespace, IWbemObjectAccess pTemplate, 
                                    IWbemRefresher pRefresher, int lFlags, IWbemContext pContext, 
                                    IWbemObjectAccess* ppRefreshable, int* plId);
    ///The <b>IWbemHiPerfProvider::StopRefreshing</b> method stops refreshing the object or enumerator corresponding to
    ///the supplied identifier. The WMI Refresher calls this method in response to a client request to
    ///IWbemConfiguratorRefresher::Remove. The provider should check the objects and enumerators associated with the
    ///refresher for a matching identifier. When the provider finds an identifier, the provider should remove or release
    ///the enumerator. <div class="alert"><b>Note</b> If a provider does not implement this method, it must return
    ///<b>WBEM_E_PROVIDER_NOT_CAPABLE</b>. A provider should implement <b>StopRefreshing</b> if it implements
    ///IWbemHiPerfProvider::CreateRefreshableEnum or IWbemHiPerfProvider::CreateRefreshableObject.</div><div> </div>
    ///Params:
    ///    pRefresher = A pointer to a IWbemRefresher object that contains a refresher obtained by calling
    ///                 IWbemHiPerfProvider::CreateRefresher.
    ///    lId = An integer containing a refresher identifier that uniquely identifies the object to stop refreshing.
    ///    lFlags = An integer containing the flags.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained within an <b>HRESULT</b>.
    ///    
    HRESULT StopRefreshing(IWbemRefresher pRefresher, int lId, int lFlags);
    ///The <b>IWbemHiPerfProvider::CreateRefreshableEnum</b> method creates a new refreshable enumeration. The WMI
    ///Refresher calls this method in response to a client request to IWbemConfigureRefresher::AddEnum. The provider
    ///associates the supplied IWbemHiPerfEnum object with the supplied refresher. On each call to the supplied
    ///refresher's Refresh method, the provider ensures that the enumerator contains a set of all the instances of the
    ///class listed in the <i>wszClass</i> parameter and that these instances contain updated information. One possible
    ///way to do this would be to keep an array of refreshable enumerators in the refresher. <div
    ///class="alert"><b>Note</b> If a provider does not implement this method, it must return
    ///<b>WBEM_E_PROVIDER_NOT_CAPABLE</b>.</div><div> </div>
    ///Params:
    ///    pNamespace = An IWbemServices pointer back into Windows Management, which can service any requests made by the provider.
    ///                 If <i>pNamespace</i> must call back into Windows Management during its execution, the provider calls AddRef
    ///                 on this pointer.
    ///    wszClass = Constant, <b>null</b>-terminated string of 16-bit, Unicode characters that contains the name of the class,
    ///               whose instances are refreshed in the <i>pHiPerfEnum </i> parameter.
    ///    pRefresher = Pointer to a IWbemRefresher object that contains a refresher obtained by calling
    ///                 IWbemHiPerfProvider::CreateRefresher.
    ///    lFlags = Reserved. This parameter must be 0 (zero).
    ///    pContext = Typically <b>NULL</b>; otherwise, a pointer to an IWbemContext object required by one or more dynamic class
    ///               providers. The values in the context object must be specified in the specific provider's documentation. For
    ///               more information about this parameter, see Making Calls to WMI.
    ///    pHiPerfEnum = Pointer to a IWbemHiPerfEnum object that contains the high-performance enumeration.
    ///    plId = Pointer to an integer returned by the provider that uniquely identifies the refreshable enumeration.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> that indicates the status of the method call. The following list lists
    ///    the value contained within an <b>HRESULT</b>.
    ///    
    HRESULT CreateRefreshableEnum(IWbemServices pNamespace, const(PWSTR) wszClass, IWbemRefresher pRefresher, 
                                  int lFlags, IWbemContext pContext, IWbemHiPerfEnum pHiPerfEnum, int* plId);
    ///The <b>IWbemHiPerfProvider::GetObjects</b> method inserts the non-key properties of the objects in the supplied
    ///array. WMI calls <b>GetObjects</b> in response to a IWbemServices::GetObject call. If a provider does not
    ///implement <b>GetObjects</b>, WMI attempts to service a <b>GetObject</b> request with a call to the
    ///IWbemHiPerfProvider::CreateRefreshableObject method. <div class="alert"><b>Note</b> If a provider does not
    ///implement this method, it must return <b>WBEM_E_PROVIDER_NOT_CAPABLE</b>.</div><div> </div>
    ///Params:
    ///    pNamespace = An IWbemServices pointer back into Windows Management, which can service any request made by the provider.
    ///                 The provider should call AddRef on this pointer if it is going to call back into Windows Management during
    ///                 its execution.
    ///    lNumObjects = Integer that contains the number of objects you are retrieving.
    ///    apObj = Pointer to an array of IWbemObjectAccess objects. The <b>GetObjects</b> method inserts the key properties of
    ///            each object into this array.
    ///    lFlags = Reserved. This parameter must be 0.
    ///    pContext = Typically <b>NULL</b>; otherwise, a pointer to an IWbemContext object that is required by one or more dynamic
    ///               class providers. The values in the context object must be specified in specific provider documentation. For
    ///               more information about this parameter, see Making Calls to WMI..
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained within an <b>HRESULT</b>.
    ///    
    HRESULT GetObjects(IWbemServices pNamespace, int lNumObjects, IWbemObjectAccess* apObj, int lFlags, 
                       IWbemContext pContext);
}

///The <b>IWbemDecoupledRegistrar</b> interface associates decoupled providers with WMI. This interface allows a
///process-hosted provider to define the interoperability lifetime of the interface and to coexist with other providers.
@GUID("1005CBCF-E64F-4646-BCD3-3A089D8A84B4")
interface IWbemDecoupledRegistrar : IUnknown
{
    ///The <b>IWbemDecoupledRegistrar::Register</b> method registers an object interface with WMI.
    ///Params:
    ///    a_Flags = Reserved for future use.
    ///    a_Context = Reserved for future use.
    ///    a_User = String identifying the user for this registration.
    ///    a_Locale = String identifying the locale for this registration.
    ///    a_Scope = Object path representing the binding to a WMI provider registration object in a specified namespace. The
    ///              scope object path can be <b>NULL</b>, indicating that the provider will support all namespaces.
    ///    a_Registration = Name of the provider being registered.
    ///    pIUnknown = Pointer to an object for particular registration. This interface will be queried to determine the interface
    ///                support that the object is capable of servicing.
    HRESULT Register(int a_Flags, IWbemContext a_Context, const(PWSTR) a_User, const(PWSTR) a_Locale, 
                     const(PWSTR) a_Scope, const(PWSTR) a_Registration, IUnknown pIUnknown);
    ///The <b>IWbemDecoupledRegistrar::UnRegister</b> method removes the registration of an object interface from WMI.
    HRESULT UnRegister();
}

///The <b>IWbemProviderIdentity</b> interface is implemented by an event provider if the provider registers itself using
///more than one <b>Name</b> (multiple instances of __Win32Provider) with the same CLSID value. The class provides a
///mechanism for distinguishing which named provider should be used.
@GUID("631F7D97-D993-11D2-B339-00105A1F4AAF")
interface IWbemProviderIdentity : IUnknown
{
    ///The <b>IWbemProviderIdentity::SetRegistrationObject</b> method is called by the Windows Management service prior
    ///to initializing an event provider (if the provider implements IWbemProviderIdentity). The method is used to pass
    ///to the provider the __Win32Provider instance by which the provider is being initialized. This method is only used
    ///if you have more than one provider sharing the same <b>CLSID</b>.
    ///Params:
    ///    lFlags = Reserved. This parameter must be 0 (zero).
    ///    pProvReg = Instance of __Win32Provider that announces the provider's name and <b>CLSID</b>.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> with one of the following values.
    ///    
    HRESULT SetRegistrationObject(int lFlags, IWbemClassObject pProvReg);
}

///The <b>IWbemDecoupledBasicEventProvider</b> interface is a cocreatable interface that registers decoupled providers
///with WMI. The object created should be passed into the <i>pUnknown </i>argument of IWbemDecoupledRegistrar::Register.
@GUID("86336D20-CA11-4786-9EF1-BC8A946B42FC")
interface IWbemDecoupledBasicEventProvider : IWbemDecoupledRegistrar
{
    ///The <b>IWbemDecoupledBasicEventProvider::GetSink</b> method retrieves an IWbemObjectSink object for event
    ///forwarding to WMI. This method provides for fully concurrent access.
    ///Params:
    ///    a_Flags = Reserved for future use.
    ///    a_Context = Reserved for future use.
    ///    a_Sink = Pointer to an IWbemObjectSink instance used to forward events to WMI.
    HRESULT GetSink(int a_Flags, IWbemContext a_Context, IWbemObjectSink* a_Sink);
    ///The <b>IWbemDecoupledBasicEventProvider::GetService</b> method retrieves an <b>IWbemService</b> object to be used
    ///to call back into WMI. This method provides for fully concurrent access.
    ///Params:
    ///    a_Flags = Reserved for future use.
    ///    a_Context = Reserved for future use.
    ///    a_Service = Pointer to an <b>IWbemService</b> object that can be used to retrieve information from WMI.
    HRESULT GetService(int a_Flags, IWbemContext a_Context, IWbemServices* a_Service);
}

///The <b>IWbemEventSink</b> interface initiates communication with an event provider using a restricted set of queries.
///This interface extends IWbemObjectSink, providing new methods dealing with security and performance. For more
///information about using this interface, see Writing an Event Provider and Securing WMI Events.
@GUID("3AE0080A-7E3A-4366-BF89-0FEEDC931659")
interface IWbemEventSink : IWbemObjectSink
{
    ///The <b>IWbemEventSink::SetSinkSecurity</b> method is used to set a security descriptor (SD) on a sink for all the
    ///events passing through. WMI handles the access checks based on the SD. Use this method when the provider cannot
    ///control what users are allowed to consume its events, but can set an SD for a specific sink.
    ///Params:
    ///    lSDLength = Length of security descriptor.
    ///    pSD = Security descriptor, DACL.
    ///Returns:
    ///    This method returns an <b>HRESULT</b> indicating the status of the method call. The following list lists the
    ///    value contained within an <b>HRESULT</b>.
    ///    
    HRESULT SetSinkSecurity(int lSDLength, ubyte* pSD);
    ///The <b>IWbemEventSink::IsActive</b> method is used by the provider to determine if there is interest in the
    ///events that the sink is filtering. In the case of a restricted sink, these events are defined by the queries
    ///passed to GetRestrictedSink. In the case where it is not a restricted sink, these events are defined by the
    ///queries in the event provider's registration. In the latter, the sink is always active.
    HRESULT IsActive();
    ///The <b>IWbemEventSink::GetRestrictedSink</b> method retrieves a restricted event sink. A restricted event sink is
    ///one which filters a subset of the events defined in the event provider's registration.
    ///Params:
    ///    lNumQueries = Number of queries in array.
    ///    awszQueries = Array of event queries.
    ///    pCallback = Pointer to callback for event provider.
    ///    ppSink = Pointer to created IWbemEventSink object.
    HRESULT GetRestrictedSink(int lNumQueries, const(PWSTR)* awszQueries, IUnknown pCallback, 
                              IWbemEventSink* ppSink);
    ///The <b>IWbemEventSink::SetBatchingParameters</b> method is used to set the maximum event buffer size and its
    ///associated processing latency value.
    ///Params:
    ///    lFlags = Determines batching behavior.
    ///    dwMaxBufferSize = Maximum batch buffer size. To specify maximum batch size, use MAX_INT.
    ///    dwMaxSendLatency = Maximum batch send latency. To specify infinite timeout, use <b>WBEM_INFINITE</b>.
    HRESULT SetBatchingParameters(int lFlags, uint dwMaxBufferSize, uint dwMaxSendLatency);
}

@GUID("76A6415C-CB41-11D1-8B02-00600806D9B6")
interface ISWbemServices : IDispatch
{
    HRESULT Get(BSTR strObjectPath, int iFlags, IDispatch objWbemNamedValueSet, ISWbemObject* objWbemObject);
    HRESULT GetAsync(IDispatch objWbemSink, BSTR strObjectPath, int iFlags, IDispatch objWbemNamedValueSet, 
                     IDispatch objWbemAsyncContext);
    HRESULT Delete(BSTR strObjectPath, int iFlags, IDispatch objWbemNamedValueSet);
    HRESULT DeleteAsync(IDispatch objWbemSink, BSTR strObjectPath, int iFlags, IDispatch objWbemNamedValueSet, 
                        IDispatch objWbemAsyncContext);
    HRESULT InstancesOf(BSTR strClass, int iFlags, IDispatch objWbemNamedValueSet, 
                        ISWbemObjectSet* objWbemObjectSet);
    HRESULT InstancesOfAsync(IDispatch objWbemSink, BSTR strClass, int iFlags, IDispatch objWbemNamedValueSet, 
                             IDispatch objWbemAsyncContext);
    HRESULT SubclassesOf(BSTR strSuperclass, int iFlags, IDispatch objWbemNamedValueSet, 
                         ISWbemObjectSet* objWbemObjectSet);
    HRESULT SubclassesOfAsync(IDispatch objWbemSink, BSTR strSuperclass, int iFlags, 
                              IDispatch objWbemNamedValueSet, IDispatch objWbemAsyncContext);
    HRESULT ExecQuery(BSTR strQuery, BSTR strQueryLanguage, int iFlags, IDispatch objWbemNamedValueSet, 
                      ISWbemObjectSet* objWbemObjectSet);
    HRESULT ExecQueryAsync(IDispatch objWbemSink, BSTR strQuery, BSTR strQueryLanguage, int lFlags, 
                           IDispatch objWbemNamedValueSet, IDispatch objWbemAsyncContext);
    HRESULT AssociatorsOf(BSTR strObjectPath, BSTR strAssocClass, BSTR strResultClass, BSTR strResultRole, 
                          BSTR strRole, short bClassesOnly, short bSchemaOnly, BSTR strRequiredAssocQualifier, 
                          BSTR strRequiredQualifier, int iFlags, IDispatch objWbemNamedValueSet, 
                          ISWbemObjectSet* objWbemObjectSet);
    HRESULT AssociatorsOfAsync(IDispatch objWbemSink, BSTR strObjectPath, BSTR strAssocClass, BSTR strResultClass, 
                               BSTR strResultRole, BSTR strRole, short bClassesOnly, short bSchemaOnly, 
                               BSTR strRequiredAssocQualifier, BSTR strRequiredQualifier, int iFlags, 
                               IDispatch objWbemNamedValueSet, IDispatch objWbemAsyncContext);
    HRESULT ReferencesTo(BSTR strObjectPath, BSTR strResultClass, BSTR strRole, short bClassesOnly, 
                         short bSchemaOnly, BSTR strRequiredQualifier, int iFlags, IDispatch objWbemNamedValueSet, 
                         ISWbemObjectSet* objWbemObjectSet);
    HRESULT ReferencesToAsync(IDispatch objWbemSink, BSTR strObjectPath, BSTR strResultClass, BSTR strRole, 
                              short bClassesOnly, short bSchemaOnly, BSTR strRequiredQualifier, int iFlags, 
                              IDispatch objWbemNamedValueSet, IDispatch objWbemAsyncContext);
    HRESULT ExecNotificationQuery(BSTR strQuery, BSTR strQueryLanguage, int iFlags, IDispatch objWbemNamedValueSet, 
                                  ISWbemEventSource* objWbemEventSource);
    HRESULT ExecNotificationQueryAsync(IDispatch objWbemSink, BSTR strQuery, BSTR strQueryLanguage, int iFlags, 
                                       IDispatch objWbemNamedValueSet, IDispatch objWbemAsyncContext);
    HRESULT ExecMethod(BSTR strObjectPath, BSTR strMethodName, IDispatch objWbemInParameters, int iFlags, 
                       IDispatch objWbemNamedValueSet, ISWbemObject* objWbemOutParameters);
    HRESULT ExecMethodAsync(IDispatch objWbemSink, BSTR strObjectPath, BSTR strMethodName, 
                            IDispatch objWbemInParameters, int iFlags, IDispatch objWbemNamedValueSet, 
                            IDispatch objWbemAsyncContext);
    HRESULT get_Security_(ISWbemSecurity* objWbemSecurity);
}

@GUID("76A6415B-CB41-11D1-8B02-00600806D9B6")
interface ISWbemLocator : IDispatch
{
    HRESULT ConnectServer(BSTR strServer, BSTR strNamespace, BSTR strUser, BSTR strPassword, BSTR strLocale, 
                          BSTR strAuthority, int iSecurityFlags, IDispatch objWbemNamedValueSet, 
                          ISWbemServices* objWbemServices);
    HRESULT get_Security_(ISWbemSecurity* objWbemSecurity);
}

@GUID("76A6415A-CB41-11D1-8B02-00600806D9B6")
interface ISWbemObject : IDispatch
{
    HRESULT Put_(int iFlags, IDispatch objWbemNamedValueSet, ISWbemObjectPath* objWbemObjectPath);
    HRESULT PutAsync_(IDispatch objWbemSink, int iFlags, IDispatch objWbemNamedValueSet, 
                      IDispatch objWbemAsyncContext);
    HRESULT Delete_(int iFlags, IDispatch objWbemNamedValueSet);
    HRESULT DeleteAsync_(IDispatch objWbemSink, int iFlags, IDispatch objWbemNamedValueSet, 
                         IDispatch objWbemAsyncContext);
    HRESULT Instances_(int iFlags, IDispatch objWbemNamedValueSet, ISWbemObjectSet* objWbemObjectSet);
    HRESULT InstancesAsync_(IDispatch objWbemSink, int iFlags, IDispatch objWbemNamedValueSet, 
                            IDispatch objWbemAsyncContext);
    HRESULT Subclasses_(int iFlags, IDispatch objWbemNamedValueSet, ISWbemObjectSet* objWbemObjectSet);
    HRESULT SubclassesAsync_(IDispatch objWbemSink, int iFlags, IDispatch objWbemNamedValueSet, 
                             IDispatch objWbemAsyncContext);
    HRESULT Associators_(BSTR strAssocClass, BSTR strResultClass, BSTR strResultRole, BSTR strRole, 
                         short bClassesOnly, short bSchemaOnly, BSTR strRequiredAssocQualifier, 
                         BSTR strRequiredQualifier, int iFlags, IDispatch objWbemNamedValueSet, 
                         ISWbemObjectSet* objWbemObjectSet);
    HRESULT AssociatorsAsync_(IDispatch objWbemSink, BSTR strAssocClass, BSTR strResultClass, BSTR strResultRole, 
                              BSTR strRole, short bClassesOnly, short bSchemaOnly, BSTR strRequiredAssocQualifier, 
                              BSTR strRequiredQualifier, int iFlags, IDispatch objWbemNamedValueSet, 
                              IDispatch objWbemAsyncContext);
    HRESULT References_(BSTR strResultClass, BSTR strRole, short bClassesOnly, short bSchemaOnly, 
                        BSTR strRequiredQualifier, int iFlags, IDispatch objWbemNamedValueSet, 
                        ISWbemObjectSet* objWbemObjectSet);
    HRESULT ReferencesAsync_(IDispatch objWbemSink, BSTR strResultClass, BSTR strRole, short bClassesOnly, 
                             short bSchemaOnly, BSTR strRequiredQualifier, int iFlags, 
                             IDispatch objWbemNamedValueSet, IDispatch objWbemAsyncContext);
    HRESULT ExecMethod_(BSTR strMethodName, IDispatch objWbemInParameters, int iFlags, 
                        IDispatch objWbemNamedValueSet, ISWbemObject* objWbemOutParameters);
    HRESULT ExecMethodAsync_(IDispatch objWbemSink, BSTR strMethodName, IDispatch objWbemInParameters, int iFlags, 
                             IDispatch objWbemNamedValueSet, IDispatch objWbemAsyncContext);
    HRESULT Clone_(ISWbemObject* objWbemObject);
    HRESULT GetObjectText_(int iFlags, BSTR* strObjectText);
    HRESULT SpawnDerivedClass_(int iFlags, ISWbemObject* objWbemObject);
    HRESULT SpawnInstance_(int iFlags, ISWbemObject* objWbemObject);
    HRESULT CompareTo_(IDispatch objWbemObject, int iFlags, short* bResult);
    HRESULT get_Qualifiers_(ISWbemQualifierSet* objWbemQualifierSet);
    HRESULT get_Properties_(ISWbemPropertySet* objWbemPropertySet);
    HRESULT get_Methods_(ISWbemMethodSet* objWbemMethodSet);
    HRESULT get_Derivation_(VARIANT* strClassNameArray);
    HRESULT get_Path_(ISWbemObjectPath* objWbemObjectPath);
    HRESULT get_Security_(ISWbemSecurity* objWbemSecurity);
}

@GUID("76A6415F-CB41-11D1-8B02-00600806D9B6")
interface ISWbemObjectSet : IDispatch
{
    HRESULT get__NewEnum(IUnknown* pUnk);
    HRESULT Item(BSTR strObjectPath, int iFlags, ISWbemObject* objWbemObject);
    HRESULT get_Count(int* iCount);
    HRESULT get_Security_(ISWbemSecurity* objWbemSecurity);
    HRESULT ItemIndex(int lIndex, ISWbemObject* objWbemObject);
}

@GUID("76A64164-CB41-11D1-8B02-00600806D9B6")
interface ISWbemNamedValue : IDispatch
{
    HRESULT get_Value(VARIANT* varValue);
    HRESULT put_Value(VARIANT* varValue);
    HRESULT get_Name(BSTR* strName);
}

@GUID("CF2376EA-CE8C-11D1-8B05-00600806D9B6")
interface ISWbemNamedValueSet : IDispatch
{
    HRESULT get__NewEnum(IUnknown* pUnk);
    HRESULT Item(BSTR strName, int iFlags, ISWbemNamedValue* objWbemNamedValue);
    HRESULT get_Count(int* iCount);
    HRESULT Add(BSTR strName, VARIANT* varValue, int iFlags, ISWbemNamedValue* objWbemNamedValue);
    HRESULT Remove(BSTR strName, int iFlags);
    HRESULT Clone(ISWbemNamedValueSet* objWbemNamedValueSet);
    HRESULT DeleteAll();
}

@GUID("79B05932-D3B7-11D1-8B06-00600806D9B6")
interface ISWbemQualifier : IDispatch
{
    HRESULT get_Value(VARIANT* varValue);
    HRESULT put_Value(VARIANT* varValue);
    HRESULT get_Name(BSTR* strName);
    HRESULT get_IsLocal(short* bIsLocal);
    HRESULT get_PropagatesToSubclass(short* bPropagatesToSubclass);
    HRESULT put_PropagatesToSubclass(short bPropagatesToSubclass);
    HRESULT get_PropagatesToInstance(short* bPropagatesToInstance);
    HRESULT put_PropagatesToInstance(short bPropagatesToInstance);
    HRESULT get_IsOverridable(short* bIsOverridable);
    HRESULT put_IsOverridable(short bIsOverridable);
    HRESULT get_IsAmended(short* bIsAmended);
}

@GUID("9B16ED16-D3DF-11D1-8B08-00600806D9B6")
interface ISWbemQualifierSet : IDispatch
{
    HRESULT get__NewEnum(IUnknown* pUnk);
    HRESULT Item(BSTR name, int iFlags, ISWbemQualifier* objWbemQualifier);
    HRESULT get_Count(int* iCount);
    HRESULT Add(BSTR strName, VARIANT* varVal, short bPropagatesToSubclass, short bPropagatesToInstance, 
                short bIsOverridable, int iFlags, ISWbemQualifier* objWbemQualifier);
    HRESULT Remove(BSTR strName, int iFlags);
}

@GUID("1A388F98-D4BA-11D1-8B09-00600806D9B6")
interface ISWbemProperty : IDispatch
{
    HRESULT get_Value(VARIANT* varValue);
    HRESULT put_Value(VARIANT* varValue);
    HRESULT get_Name(BSTR* strName);
    HRESULT get_IsLocal(short* bIsLocal);
    HRESULT get_Origin(BSTR* strOrigin);
    HRESULT get_CIMType(WbemCimtypeEnum* iCimType);
    HRESULT get_Qualifiers_(ISWbemQualifierSet* objWbemQualifierSet);
    HRESULT get_IsArray(short* bIsArray);
}

@GUID("DEA0A7B2-D4BA-11D1-8B09-00600806D9B6")
interface ISWbemPropertySet : IDispatch
{
    HRESULT get__NewEnum(IUnknown* pUnk);
    HRESULT Item(BSTR strName, int iFlags, ISWbemProperty* objWbemProperty);
    HRESULT get_Count(int* iCount);
    HRESULT Add(BSTR strName, WbemCimtypeEnum iCIMType, short bIsArray, int iFlags, 
                ISWbemProperty* objWbemProperty);
    HRESULT Remove(BSTR strName, int iFlags);
}

@GUID("422E8E90-D955-11D1-8B09-00600806D9B6")
interface ISWbemMethod : IDispatch
{
    HRESULT get_Name(BSTR* strName);
    HRESULT get_Origin(BSTR* strOrigin);
    HRESULT get_InParameters(ISWbemObject* objWbemInParameters);
    HRESULT get_OutParameters(ISWbemObject* objWbemOutParameters);
    HRESULT get_Qualifiers_(ISWbemQualifierSet* objWbemQualifierSet);
}

@GUID("C93BA292-D955-11D1-8B09-00600806D9B6")
interface ISWbemMethodSet : IDispatch
{
    HRESULT get__NewEnum(IUnknown* pUnk);
    HRESULT Item(BSTR strName, int iFlags, ISWbemMethod* objWbemMethod);
    HRESULT get_Count(int* iCount);
}

@GUID("27D54D92-0EBE-11D2-8B22-00600806D9B6")
interface ISWbemEventSource : IDispatch
{
    HRESULT NextEvent(int iTimeoutMs, ISWbemObject* objWbemObject);
    HRESULT get_Security_(ISWbemSecurity* objWbemSecurity);
}

@GUID("5791BC27-CE9C-11D1-97BF-0000F81E849C")
interface ISWbemObjectPath : IDispatch
{
    HRESULT get_Path(BSTR* strPath);
    HRESULT put_Path(BSTR strPath);
    HRESULT get_RelPath(BSTR* strRelPath);
    HRESULT put_RelPath(BSTR strRelPath);
    HRESULT get_Server(BSTR* strServer);
    HRESULT put_Server(BSTR strServer);
    HRESULT get_Namespace(BSTR* strNamespace);
    HRESULT put_Namespace(BSTR strNamespace);
    HRESULT get_ParentNamespace(BSTR* strParentNamespace);
    HRESULT get_DisplayName(BSTR* strDisplayName);
    HRESULT put_DisplayName(BSTR strDisplayName);
    HRESULT get_Class(BSTR* strClass);
    HRESULT put_Class(BSTR strClass);
    HRESULT get_IsClass(short* bIsClass);
    HRESULT SetAsClass();
    HRESULT get_IsSingleton(short* bIsSingleton);
    HRESULT SetAsSingleton();
    HRESULT get_Keys(ISWbemNamedValueSet* objWbemNamedValueSet);
    HRESULT get_Security_(ISWbemSecurity* objWbemSecurity);
    HRESULT get_Locale(BSTR* strLocale);
    HRESULT put_Locale(BSTR strLocale);
    HRESULT get_Authority(BSTR* strAuthority);
    HRESULT put_Authority(BSTR strAuthority);
}

@GUID("D962DB84-D4BB-11D1-8B09-00600806D9B6")
interface ISWbemLastError : ISWbemObject
{
}

@GUID("75718CA0-F029-11D1-A1AC-00C04FB6C223")
interface ISWbemSinkEvents : IDispatch
{
}

@GUID("75718C9F-F029-11D1-A1AC-00C04FB6C223")
interface ISWbemSink : IDispatch
{
    HRESULT Cancel();
}

@GUID("B54D66E6-2287-11D2-8B33-00600806D9B6")
interface ISWbemSecurity : IDispatch
{
    HRESULT get_ImpersonationLevel(WbemImpersonationLevelEnum* iImpersonationLevel);
    HRESULT put_ImpersonationLevel(WbemImpersonationLevelEnum iImpersonationLevel);
    HRESULT get_AuthenticationLevel(WbemAuthenticationLevelEnum* iAuthenticationLevel);
    HRESULT put_AuthenticationLevel(WbemAuthenticationLevelEnum iAuthenticationLevel);
    HRESULT get_Privileges(ISWbemPrivilegeSet* objWbemPrivilegeSet);
}

@GUID("26EE67BD-5804-11D2-8B4A-00600806D9B6")
interface ISWbemPrivilege : IDispatch
{
    HRESULT get_IsEnabled(short* bIsEnabled);
    HRESULT put_IsEnabled(short bIsEnabled);
    HRESULT get_Name(BSTR* strDisplayName);
    HRESULT get_DisplayName(BSTR* strDisplayName);
    HRESULT get_Identifier(WbemPrivilegeEnum* iPrivilege);
}

@GUID("26EE67BF-5804-11D2-8B4A-00600806D9B6")
interface ISWbemPrivilegeSet : IDispatch
{
    HRESULT get__NewEnum(IUnknown* pUnk);
    HRESULT Item(WbemPrivilegeEnum iPrivilege, ISWbemPrivilege* objWbemPrivilege);
    HRESULT get_Count(int* iCount);
    HRESULT Add(WbemPrivilegeEnum iPrivilege, short bIsEnabled, ISWbemPrivilege* objWbemPrivilege);
    HRESULT Remove(WbemPrivilegeEnum iPrivilege);
    HRESULT DeleteAll();
    HRESULT AddAsString(BSTR strPrivilege, short bIsEnabled, ISWbemPrivilege* objWbemPrivilege);
}

@GUID("D2F68443-85DC-427E-91D8-366554CC754C")
interface ISWbemServicesEx : ISWbemServices
{
    HRESULT Put(ISWbemObjectEx objWbemObject, int iFlags, IDispatch objWbemNamedValueSet, 
                ISWbemObjectPath* objWbemObjectPath);
    HRESULT PutAsync(ISWbemSink objWbemSink, ISWbemObjectEx objWbemObject, int iFlags, 
                     IDispatch objWbemNamedValueSet, IDispatch objWbemAsyncContext);
}

@GUID("269AD56A-8A67-4129-BC8C-0506DCFE9880")
interface ISWbemObjectEx : ISWbemObject
{
    HRESULT Refresh_(int iFlags, IDispatch objWbemNamedValueSet);
    HRESULT get_SystemProperties_(ISWbemPropertySet* objWbemPropertySet);
    HRESULT GetText_(WbemObjectTextFormatEnum iObjectTextFormat, int iFlags, IDispatch objWbemNamedValueSet, 
                     BSTR* bsText);
    HRESULT SetFromText_(BSTR bsText, WbemObjectTextFormatEnum iObjectTextFormat, int iFlags, 
                         IDispatch objWbemNamedValueSet);
}

@GUID("5E97458A-CF77-11D3-B38F-00105A1F473A")
interface ISWbemDateTime : IDispatch
{
    HRESULT get_Value(BSTR* strValue);
    HRESULT put_Value(BSTR strValue);
    HRESULT get_Year(int* iYear);
    HRESULT put_Year(int iYear);
    HRESULT get_YearSpecified(short* bYearSpecified);
    HRESULT put_YearSpecified(short bYearSpecified);
    HRESULT get_Month(int* iMonth);
    HRESULT put_Month(int iMonth);
    HRESULT get_MonthSpecified(short* bMonthSpecified);
    HRESULT put_MonthSpecified(short bMonthSpecified);
    HRESULT get_Day(int* iDay);
    HRESULT put_Day(int iDay);
    HRESULT get_DaySpecified(short* bDaySpecified);
    HRESULT put_DaySpecified(short bDaySpecified);
    HRESULT get_Hours(int* iHours);
    HRESULT put_Hours(int iHours);
    HRESULT get_HoursSpecified(short* bHoursSpecified);
    HRESULT put_HoursSpecified(short bHoursSpecified);
    HRESULT get_Minutes(int* iMinutes);
    HRESULT put_Minutes(int iMinutes);
    HRESULT get_MinutesSpecified(short* bMinutesSpecified);
    HRESULT put_MinutesSpecified(short bMinutesSpecified);
    HRESULT get_Seconds(int* iSeconds);
    HRESULT put_Seconds(int iSeconds);
    HRESULT get_SecondsSpecified(short* bSecondsSpecified);
    HRESULT put_SecondsSpecified(short bSecondsSpecified);
    HRESULT get_Microseconds(int* iMicroseconds);
    HRESULT put_Microseconds(int iMicroseconds);
    HRESULT get_MicrosecondsSpecified(short* bMicrosecondsSpecified);
    HRESULT put_MicrosecondsSpecified(short bMicrosecondsSpecified);
    HRESULT get_UTC(int* iUTC);
    HRESULT put_UTC(int iUTC);
    HRESULT get_UTCSpecified(short* bUTCSpecified);
    HRESULT put_UTCSpecified(short bUTCSpecified);
    HRESULT get_IsInterval(short* bIsInterval);
    HRESULT put_IsInterval(short bIsInterval);
    HRESULT GetVarDate(short bIsLocal, double* dVarDate);
    HRESULT SetVarDate(double dVarDate, short bIsLocal);
    HRESULT GetFileTime(short bIsLocal, BSTR* strFileTime);
    HRESULT SetFileTime(BSTR strFileTime, short bIsLocal);
}

@GUID("14D8250E-D9C2-11D3-B38F-00105A1F473A")
interface ISWbemRefresher : IDispatch
{
    HRESULT get__NewEnum(IUnknown* pUnk);
    HRESULT Item(int iIndex, ISWbemRefreshableItem* objWbemRefreshableItem);
    HRESULT get_Count(int* iCount);
    HRESULT Add(ISWbemServicesEx objWbemServices, BSTR bsInstancePath, int iFlags, IDispatch objWbemNamedValueSet, 
                ISWbemRefreshableItem* objWbemRefreshableItem);
    HRESULT AddEnum(ISWbemServicesEx objWbemServices, BSTR bsClassName, int iFlags, IDispatch objWbemNamedValueSet, 
                    ISWbemRefreshableItem* objWbemRefreshableItem);
    HRESULT Remove(int iIndex, int iFlags);
    HRESULT Refresh(int iFlags);
    HRESULT get_AutoReconnect(short* bCount);
    HRESULT put_AutoReconnect(short bCount);
    HRESULT DeleteAll();
}

@GUID("5AD4BF92-DAAB-11D3-B38F-00105A1F473A")
interface ISWbemRefreshableItem : IDispatch
{
    HRESULT get_Index(int* iIndex);
    HRESULT get_Refresher(ISWbemRefresher* objWbemRefresher);
    HRESULT get_IsSet(short* bIsSet);
    HRESULT get_Object(ISWbemObjectEx* objWbemObject);
    HRESULT get_ObjectSet(ISWbemObjectSet* objWbemObjectSet);
    HRESULT Remove(int iFlags);
}


// GUIDs

const GUID CLSID_MofCompiler                     = GUIDOF!MofCompiler;
const GUID CLSID_SWbemDateTime                   = GUIDOF!SWbemDateTime;
const GUID CLSID_SWbemEventSource                = GUIDOF!SWbemEventSource;
const GUID CLSID_SWbemLastError                  = GUIDOF!SWbemLastError;
const GUID CLSID_SWbemLocator                    = GUIDOF!SWbemLocator;
const GUID CLSID_SWbemMethod                     = GUIDOF!SWbemMethod;
const GUID CLSID_SWbemMethodSet                  = GUIDOF!SWbemMethodSet;
const GUID CLSID_SWbemNamedValue                 = GUIDOF!SWbemNamedValue;
const GUID CLSID_SWbemNamedValueSet              = GUIDOF!SWbemNamedValueSet;
const GUID CLSID_SWbemObject                     = GUIDOF!SWbemObject;
const GUID CLSID_SWbemObjectEx                   = GUIDOF!SWbemObjectEx;
const GUID CLSID_SWbemObjectPath                 = GUIDOF!SWbemObjectPath;
const GUID CLSID_SWbemObjectSet                  = GUIDOF!SWbemObjectSet;
const GUID CLSID_SWbemPrivilege                  = GUIDOF!SWbemPrivilege;
const GUID CLSID_SWbemPrivilegeSet               = GUIDOF!SWbemPrivilegeSet;
const GUID CLSID_SWbemProperty                   = GUIDOF!SWbemProperty;
const GUID CLSID_SWbemPropertySet                = GUIDOF!SWbemPropertySet;
const GUID CLSID_SWbemQualifier                  = GUIDOF!SWbemQualifier;
const GUID CLSID_SWbemQualifierSet               = GUIDOF!SWbemQualifierSet;
const GUID CLSID_SWbemRefreshableItem            = GUIDOF!SWbemRefreshableItem;
const GUID CLSID_SWbemRefresher                  = GUIDOF!SWbemRefresher;
const GUID CLSID_SWbemSecurity                   = GUIDOF!SWbemSecurity;
const GUID CLSID_SWbemServices                   = GUIDOF!SWbemServices;
const GUID CLSID_SWbemServicesEx                 = GUIDOF!SWbemServicesEx;
const GUID CLSID_SWbemSink                       = GUIDOF!SWbemSink;
const GUID CLSID_UnsecuredApartment              = GUIDOF!UnsecuredApartment;
const GUID CLSID_WbemAdministrativeLocator       = GUIDOF!WbemAdministrativeLocator;
const GUID CLSID_WbemAuthenticatedLocator        = GUIDOF!WbemAuthenticatedLocator;
const GUID CLSID_WbemBackupRestore               = GUIDOF!WbemBackupRestore;
const GUID CLSID_WbemClassObject                 = GUIDOF!WbemClassObject;
const GUID CLSID_WbemContext                     = GUIDOF!WbemContext;
const GUID CLSID_WbemDecoupledBasicEventProvider = GUIDOF!WbemDecoupledBasicEventProvider;
const GUID CLSID_WbemDecoupledRegistrar          = GUIDOF!WbemDecoupledRegistrar;
const GUID CLSID_WbemDefPath                     = GUIDOF!WbemDefPath;
const GUID CLSID_WbemLocator                     = GUIDOF!WbemLocator;
const GUID CLSID_WbemObjectTextSrc               = GUIDOF!WbemObjectTextSrc;
const GUID CLSID_WbemQuery                       = GUIDOF!WbemQuery;
const GUID CLSID_WbemRefresher                   = GUIDOF!WbemRefresher;
const GUID CLSID_WbemStatusCodeText              = GUIDOF!WbemStatusCodeText;
const GUID CLSID_WbemUnauthenticatedLocator      = GUIDOF!WbemUnauthenticatedLocator;

const GUID IID_IEnumWbemClassObject             = GUIDOF!IEnumWbemClassObject;
const GUID IID_IMofCompiler                     = GUIDOF!IMofCompiler;
const GUID IID_ISWbemDateTime                   = GUIDOF!ISWbemDateTime;
const GUID IID_ISWbemEventSource                = GUIDOF!ISWbemEventSource;
const GUID IID_ISWbemLastError                  = GUIDOF!ISWbemLastError;
const GUID IID_ISWbemLocator                    = GUIDOF!ISWbemLocator;
const GUID IID_ISWbemMethod                     = GUIDOF!ISWbemMethod;
const GUID IID_ISWbemMethodSet                  = GUIDOF!ISWbemMethodSet;
const GUID IID_ISWbemNamedValue                 = GUIDOF!ISWbemNamedValue;
const GUID IID_ISWbemNamedValueSet              = GUIDOF!ISWbemNamedValueSet;
const GUID IID_ISWbemObject                     = GUIDOF!ISWbemObject;
const GUID IID_ISWbemObjectEx                   = GUIDOF!ISWbemObjectEx;
const GUID IID_ISWbemObjectPath                 = GUIDOF!ISWbemObjectPath;
const GUID IID_ISWbemObjectSet                  = GUIDOF!ISWbemObjectSet;
const GUID IID_ISWbemPrivilege                  = GUIDOF!ISWbemPrivilege;
const GUID IID_ISWbemPrivilegeSet               = GUIDOF!ISWbemPrivilegeSet;
const GUID IID_ISWbemProperty                   = GUIDOF!ISWbemProperty;
const GUID IID_ISWbemPropertySet                = GUIDOF!ISWbemPropertySet;
const GUID IID_ISWbemQualifier                  = GUIDOF!ISWbemQualifier;
const GUID IID_ISWbemQualifierSet               = GUIDOF!ISWbemQualifierSet;
const GUID IID_ISWbemRefreshableItem            = GUIDOF!ISWbemRefreshableItem;
const GUID IID_ISWbemRefresher                  = GUIDOF!ISWbemRefresher;
const GUID IID_ISWbemSecurity                   = GUIDOF!ISWbemSecurity;
const GUID IID_ISWbemServices                   = GUIDOF!ISWbemServices;
const GUID IID_ISWbemServicesEx                 = GUIDOF!ISWbemServicesEx;
const GUID IID_ISWbemSink                       = GUIDOF!ISWbemSink;
const GUID IID_ISWbemSinkEvents                 = GUIDOF!ISWbemSinkEvents;
const GUID IID_IUnsecuredApartment              = GUIDOF!IUnsecuredApartment;
const GUID IID_IWbemBackupRestore               = GUIDOF!IWbemBackupRestore;
const GUID IID_IWbemBackupRestoreEx             = GUIDOF!IWbemBackupRestoreEx;
const GUID IID_IWbemCallResult                  = GUIDOF!IWbemCallResult;
const GUID IID_IWbemClassObject                 = GUIDOF!IWbemClassObject;
const GUID IID_IWbemConfigureRefresher          = GUIDOF!IWbemConfigureRefresher;
const GUID IID_IWbemContext                     = GUIDOF!IWbemContext;
const GUID IID_IWbemDecoupledBasicEventProvider = GUIDOF!IWbemDecoupledBasicEventProvider;
const GUID IID_IWbemDecoupledRegistrar          = GUIDOF!IWbemDecoupledRegistrar;
const GUID IID_IWbemEventConsumerProvider       = GUIDOF!IWbemEventConsumerProvider;
const GUID IID_IWbemEventProvider               = GUIDOF!IWbemEventProvider;
const GUID IID_IWbemEventProviderQuerySink      = GUIDOF!IWbemEventProviderQuerySink;
const GUID IID_IWbemEventProviderSecurity       = GUIDOF!IWbemEventProviderSecurity;
const GUID IID_IWbemEventSink                   = GUIDOF!IWbemEventSink;
const GUID IID_IWbemHiPerfEnum                  = GUIDOF!IWbemHiPerfEnum;
const GUID IID_IWbemHiPerfProvider              = GUIDOF!IWbemHiPerfProvider;
const GUID IID_IWbemLocator                     = GUIDOF!IWbemLocator;
const GUID IID_IWbemObjectAccess                = GUIDOF!IWbemObjectAccess;
const GUID IID_IWbemObjectSink                  = GUIDOF!IWbemObjectSink;
const GUID IID_IWbemObjectSinkEx                = GUIDOF!IWbemObjectSinkEx;
const GUID IID_IWbemObjectTextSrc               = GUIDOF!IWbemObjectTextSrc;
const GUID IID_IWbemPath                        = GUIDOF!IWbemPath;
const GUID IID_IWbemPathKeyList                 = GUIDOF!IWbemPathKeyList;
const GUID IID_IWbemPropertyProvider            = GUIDOF!IWbemPropertyProvider;
const GUID IID_IWbemProviderIdentity            = GUIDOF!IWbemProviderIdentity;
const GUID IID_IWbemProviderInit                = GUIDOF!IWbemProviderInit;
const GUID IID_IWbemProviderInitSink            = GUIDOF!IWbemProviderInitSink;
const GUID IID_IWbemQualifierSet                = GUIDOF!IWbemQualifierSet;
const GUID IID_IWbemQuery                       = GUIDOF!IWbemQuery;
const GUID IID_IWbemRefresher                   = GUIDOF!IWbemRefresher;
const GUID IID_IWbemServices                    = GUIDOF!IWbemServices;
const GUID IID_IWbemShutdown                    = GUIDOF!IWbemShutdown;
const GUID IID_IWbemStatusCodeText              = GUIDOF!IWbemStatusCodeText;
const GUID IID_IWbemUnboundObjectSink           = GUIDOF!IWbemUnboundObjectSink;
const GUID IID_IWbemUnsecuredApartment          = GUIDOF!IWbemUnsecuredApartment;
