tableextension 90501 "Item Ledger Entry Ext" extends "Item Ledger Entry"
{
    fields
    {
        field(90500; "Custom Field 1"; Code[20])
        {
            Caption = '"Custom Field 1"';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(90501; "Custom Field 2"; Integer)
        {
            Caption = 'Custom Field 2';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }
}
