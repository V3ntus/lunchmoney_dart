import 'package:lunchmoney/src/enums.dart';
import 'package:lunchmoney/src/models/category.dart';
import 'package:lunchmoney/src/models/_base.dart';
import 'package:lunchmoney/src/models/tag.dart';


class Transaction implements LunchMoneyModel {
  /// Unique identifier for transaction.
  @override
  final int id;

  /// Date of transaction
  final DateTime date;

  /// Name of payee. If [recurringID] is not null, this field will show the payee of
  /// associated recurring expense instead of the original transaction payee
  final String payee;

  /// Amount of the transaction in numeric format to 4 decimal places
  final double amount;

  /// Three-letter lowercase currency code of the transaction in ISO 4217 format
  final String currency;

  /// The amount converted to the user's primary currency.
  /// If the multicurrency feature is not being used, to_base and amount will be the same.
  final double toBase;

  /// Unique identifier of associated category (see [Category])
  final int? categoryId;

  /// Name of [Category] associated with transaction.
  final String? categoryName;

  /// Unique identifier of associated [Category] group, if any.
  final int? categoryGroupId;

  /// Name of [Category] group associated with transaction, if any.
  final String? categoryGroupName;

  /// Based on the associated category's property, denotes if transaction is treated as income
  final bool isIncome;

  /// Based on the associated category's property, denotes if transaction is excluded from budget
  final bool excludeFromBudget;

  /// Based on the associated category's property, denotes if transaction is excluded from totals
  final bool excludeFromTotals;

  /// The date and time of when the transaction was created.
  final DateTime createdAt;

  /// The date and time of when the transaction was last updated.
  final DateTime updatedAt;

  /// The status of this transaction. User intervention is required to change this to recurring.
  final TransactionStatus? status;

  /// Denotes if transaction is pending (not posted)
  final bool isPending;

  /// User-entered transaction notes. If [recurringID] is not null, this field will be description
  /// of associated recurring expense.
  final String? notes;

  /// The transactions original name before any payee name updates. For synced transactions,
  /// this is the raw original payee name from your bank.
  final String originalName;

  /// Unique identifier of associated recurring item.
  final int? recurringID;

  /// Payee name of associated recurring item.
  final String? recurringPayee;

  /// Description of associated recurring item.
  final String? recurringDescription;

  /// Cadence of associated recurring item.
  final RecurringCadence? recurringCadence;

  /// Type of associated recurring.
  final RecurringType? recurringType;

  /// Amount of associated recurring item.
  final double? recurringAmount;

  /// Currency of associated recurring item.
  final String? recurringCurrency;

  /// Exists if this is a split transaction. Denotes the transaction ID of the original transaction.
  /// Note that the parent transaction is not returned in this call.
  final int? parentId;

  /// True if this transaction is a parent transaction and is split into 2 or more other transactions.
  final bool hasChildren;

  /// Exists if this transaction is part of a group. Denotes the parent’s transaction ID.
  final int? groupId;

  /// True if this transaction represents a group of transactions.
  /// If so, amount and currency represent the totalled amount of transactions bearing this transaction’s id as
  /// their group_id. Amount is calculated based on the user’s primary currency.
  final bool isGroup;

  /// Unique identifier of associated manually-managed account (see Assets)
  /// Note: [plaidAccountId] and [assetId] cannot both exist for a transaction
  final int? assetId;

  /// Institution name of associated manually-managed account.
  final String? assetInstitutionName;

  /// Name of associated manually-managed account.
  final String? assetName;

  /// Display name of associated manually-managed account.
  final String? assetDisplayName;

  /// Status of associated manually-managed account.
  final AssetStatus? assetStatus;

  /// Unique identifier of associated Plaid account (see Plaid Accounts)
  /// Note: [plaidAccountId] and [assetId] cannot both exist for a transaction
  final int? plaidAccountId;

  /// Name of associated Plaid account.
  final String? plaidAccountName;

  /// Mask of associated Plaid account
  final String? plaidAccountMask;

  /// Institution name of associated Plaid account
  final String? institutionName;

  /// Display name of associated Plaid account
  final String? plaidAccountDisplayName;

  /// Metadata associated with imported transaction from Plaid
  final String? plaidMetadata;

  /// Source of the transaction
  final TransactionSource source;

  /// Display name for payee for transaction based on whether or not it is linked to a recurring item.
  /// If linked, returns [recurringPayee] field. Otherwise, returns the [payee] field.
  final String displayName;

  /// Display notes for transaction based on whether or not it is linked to a recurring item.
  /// If linked, returns [recurringNotes] field. Otherwise, returns the [notes] field.
  final String? displayNotes;

  /// Display name for associated account (manual or Plaid).
  /// If this is a synced account, returns [plaidAccountDisplayName] or [assetDisplayName].
  final String? accountDisplayName;

  /// Array of [Tag] objects
  final List<Tag>? tags;

  /// Array of child Transaction objections, these objects are slimmed down to the more essential fields,
  /// and contain an extra field called formatted_date that contains the date of transaction in ISO 8601 format
  final List<Transaction>? children;

  /// User-defined external ID for any manually-entered or imported transaction. External ID cannot be accessed or
  /// changed for Plaid-imported transactions. External ID must be unique by asset_id. Max 75 characters.
  final String? externalId;

  Transaction({
    required this.id,
    required this.date,
    required this.payee,
    required this.amount,
    required this.currency,
    required this.toBase,
    this.categoryId,
    this.categoryName,
    this.categoryGroupId,
    this.categoryGroupName,
    required this.isIncome,
    required this.excludeFromBudget,
    required this.excludeFromTotals,
    required this.createdAt,
    required this.updatedAt,
    this.status,
    required this.isPending,
    this.notes,
    required this.originalName,
    this.recurringID,
    this.recurringPayee,
    this.recurringDescription,
    this.recurringCadence,
    this.recurringType,
    this.recurringAmount,
    this.recurringCurrency,
    this.parentId,
    required this.hasChildren,
    this.groupId,
    required this.isGroup,
    this.assetId,
    this.assetInstitutionName,
    this.assetName,
    this.assetDisplayName,
    this.assetStatus,
    this.plaidAccountId,
    this.plaidAccountName,
    this.plaidAccountMask,
    this.institutionName,
    this.plaidAccountDisplayName,
    this.plaidMetadata,
    required this.source,
    required this.displayName,
    this.displayNotes,
    this.accountDisplayName,
    this.tags,
    this.children,
    required this.externalId,
  });

  static Transaction fromJson(Map<String, dynamic> data) {
    return Transaction(
      id: int.parse(data['id']),
      date: DateTime.parse(data['date']),
      payee: data['payee'],
      amount: double.parse(data['amount']),
      currency: data['currency'],
      toBase: double.parse(data['to_base']),
      categoryId: int.tryParse(data['category_id']),
      categoryName: data['category_name'],
      categoryGroupId: int.tryParse(data['category_group_id']),
      categoryGroupName: data['category_group_name'],
      isIncome: data['is_income'],
      excludeFromBudget: data['exclude_from_budget'],
      excludeFromTotals: data['exclude_from_totals'],
      createdAt: DateTime.parse(data['created_at']),
      updatedAt: DateTime.parse(data['updated_at']),
      status: data['status'] != null ? TransactionStatus.fromString(data["status"]) : null,
      isPending: data['is_pending'],
      notes: data['notes'],
      originalName: data['original_name'],
      recurringID: int.tryParse(data['recurring_id']),
      recurringPayee: data['recurring_payee'],
      recurringDescription: data['recurring_description'],
      recurringCadence:
          data['recurring_cadence'] != null ? RecurringCadence.fromString(data['recurring_cadence']) : null,
      recurringType: data['recurring_type'] != null ? RecurringType.fromString(data['recurring_type']) : null,
      recurringAmount: double.tryParse(data['recurring_amount']),
      recurringCurrency: data['recurring_currency'],
      parentId: int.tryParse(data['parent_id']),
      hasChildren: data['has_children'],
      groupId: int.tryParse(data['group_id']),
      isGroup: data['is_group'],
      assetId: int.tryParse(data['asset_id']),
      assetInstitutionName: data['asset_institution_name'],
      assetName: data['asset_name'],
      assetDisplayName: data['asset_display_name'],
      assetStatus: data['asset_status'] != null ? AssetStatus.fromString(data['asset_status']) : null,
      plaidAccountId: int.tryParse(data['plaid_account_id']),
      plaidAccountName: data['plaid_account_name'],
      plaidAccountMask: data['plaid_account_mask'],
      institutionName: data['institution_name'],
      plaidAccountDisplayName: data['plaid_account_display_name'],
      plaidMetadata: data['plaid_metadata'],
      source: TransactionSource.fromString(data['source']),
      displayName: data['display_name'],
      displayNotes: data['display_notes'],
      accountDisplayName: data['account_display_name'],
      tags: (data['tags'] != null)
          ? List<Tag>.from(
              data['tags'].map(
                (tag) => Tag.fromJson(tag),
              ),
            )
          : null,
      children: (data['children'] != null)
          ? List<Transaction>.from(
              data['children'].map(
                (child) => fromJson(
                  {
                    ...data,
                    ...child,
                  },
                ),
              ),
            )
          : null,
      externalId: data['external_id'],
    );
  }
}
