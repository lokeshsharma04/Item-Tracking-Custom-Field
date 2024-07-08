pageextension 90501 "Item Ledger Entries Ext" extends "Item Ledger Entries"
{
    layout
    {
        addafter(Quantity)
        {
            field("Custom Field 1"; Rec."Custom Field 1")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the "Custom Field 1" field.';
            }
            field("Custom Field 2"; Rec."Custom Field 2")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Custom Field 2 field.';
            }
        }
    }
}
