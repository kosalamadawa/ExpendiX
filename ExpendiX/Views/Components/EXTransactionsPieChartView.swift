//
//  EXTransactionsPieChartView.swift
//  ExpendiX
//
//  Created by Kosala Rathnayake on 2023-09-26.
//

import SwiftUI
import SwiftUICharts

struct EXLegend {
    let category: String
    let amount: Double
}

struct EXTransactionsPieChartView: View {
    var type: EXTransactionType
    var expenses: [EXExpense] = []
    var incomes: [EXIncome] = []
    
    var gridLayout: [GridItem] {
        return  Array(repeating: GridItem(.flexible()), count: 2)
    }
    
    var colors: [Color] = [
        .blue,
        .red,
        .yellow,
        .green,
        .orange,
        .brown,
        .purple,
    ]
    
    var pieColors: [ColorGradient] {
        var gradients: [ColorGradient] = []
        for colorItem in colors {
            gradients.append(ColorGradient(colorItem.opacity(0.5), colorItem))
        }
        return gradients
    }
    
    var piechartData: [Double] {
        var data: [Double] = []
        if type == .expense {
            for expense in expenses {
                data.append(expense.amount)
            }
        } else {
            for income in incomes {
                data.append(income.amount)
            }
        }
        return data
    }
    
    var legendData: [EXLegend] {
        var legendData: [EXLegend] = []
        if type == .expense {
            for expense in expenses {
                legendData.append(EXLegend(category: expense.category.text, amount: expense.amount))
            }
        } else {
            for income in incomes {
                legendData.append(EXLegend(category: income.category.text, amount: income.amount))
            }
        }
        return legendData
    }
    
    var body: some View {
        VStack {
            PieChart()
                .data(piechartData)
                .chartStyle(
                    ChartStyle(
                        backgroundColor: .white,
                        foregroundColor: pieColors
                    )
                )
                .frame(width: 300, height: 300)
                .padding(.vertical, 16)
            
            LazyVGrid(columns: gridLayout) {
                ForEach(0 ..< piechartData.count) { legendIndex in
                    HStack(alignment: .top) {
                        Circle()
                            .fill(colors[legendIndex])
                            .frame(width: 10)
                            .offset(y: 3)
                        VStack(alignment: .leading, spacing: 8) {
                            Text(legendData[legendIndex].category)
                                .foregroundColor(Color("ColorLight20"))
                                .font(.system(size: 12, weight: .medium))
                            Text("\(legendData[legendIndex].amount, specifier: "%.2f")")
                                .font(.system(size: 16, weight: .medium))
                        }
                        Spacer()
                    }
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color("ColorLight60"))
                    }
                }
            }
        }
    }
}

struct EXTransactionsPieChartView_Previews: PreviewProvider {
    static var previews: some View {
        EXTransactionsPieChartView(type: .expense, expenses: [
            EXExpense(
                id: "1",
                userId: "234",
                amount: 2000.00,
                description: "Test",
                category: .transportation,
                date: Date().timeIntervalSince1970
            ),
            EXExpense(
                id: "2",
                userId: "234",
                amount: 8000.00,
                description: "Test",
                category: .billsAndUtilities,
                date: Date().timeIntervalSince1970
            ),
            EXExpense(
                id: "3",
                userId: "234",
                amount: 5000.00,
                description: "Test",
                category: .entertainment,
                date: Date().timeIntervalSince1970
            ),
            EXExpense(
                id: "4",
                userId: "234",
                amount: 20000.00,
                description: "Test",
                category: .housing,
                date: Date().timeIntervalSince1970
            ),
            EXExpense(
                id: "5",
                userId: "234",
                amount: 55000.00,
                description: "Test",
                category: .foodAndDining,
                date: Date().timeIntervalSince1970
            ),
        ])
    }
}
