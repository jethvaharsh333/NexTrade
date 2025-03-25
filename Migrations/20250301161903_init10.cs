using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace NexTrade.Migrations
{
    /// <inheritdoc />
    public partial class init10 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Portfolios_Stocks_StockID",
                table: "Portfolios");

            migrationBuilder.DropColumn(
                name: "StockSymbol",
                table: "Portfolios");

            migrationBuilder.AlterColumn<int>(
                name: "StockID",
                table: "Portfolios",
                type: "int",
                nullable: false,
                defaultValue: 0,
                oldClrType: typeof(int),
                oldType: "int",
                oldNullable: true);

            migrationBuilder.AddForeignKey(
                name: "FK_Portfolios_Stocks_StockID",
                table: "Portfolios",
                column: "StockID",
                principalTable: "Stocks",
                principalColumn: "StockID",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Portfolios_Stocks_StockID",
                table: "Portfolios");

            migrationBuilder.AlterColumn<int>(
                name: "StockID",
                table: "Portfolios",
                type: "int",
                nullable: true,
                oldClrType: typeof(int),
                oldType: "int");

            migrationBuilder.AddColumn<string>(
                name: "StockSymbol",
                table: "Portfolios",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddForeignKey(
                name: "FK_Portfolios_Stocks_StockID",
                table: "Portfolios",
                column: "StockID",
                principalTable: "Stocks",
                principalColumn: "StockID");
        }
    }
}
