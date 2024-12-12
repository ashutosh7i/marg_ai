/* eslint-disable react/prop-types */
import { useState } from "react";
import { useTranslation } from "react-i18next";
import {
  BarChart,
  Bar,
  YAxis,
  CartesianGrid,
  Tooltip,
  Legend,
  ResponsiveContainer,
} from "recharts";

const ClassPerformanceChart = ({ data }) => {
  const { t } = useTranslation("overview-banner");

  const [selectedMonth, setSelectedMonth] = useState("January");

  const months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];

  const filteredData = data.filter(
    (item) => item.month === selectedMonth.substring(0, 3)
  );

  const CustomTooltip = ({ active, payload }) => {
    if (active && payload && payload.length) {
      return (
        <div className="rounded-lg border border-gray-200 bg-white p-4 shadow-lg">
          {payload.map((entry, index) => (
            <div key={index} className="flex items-center gap-2">
              <div
                className="h-3 w-3 rounded-full"
                style={{ backgroundColor: entry.fill }}
              />
              <p className="text-sm">
                {entry.name}: {entry.value}
              </p>
            </div>
          ))}
        </div>
      );
    }
    return null;
  };

  const getRandomColor = () => {
    const letters = "0123456789ABCDEF";
    let color = "#";
    for (let i = 0; i < 6; i++) {
      color += letters[Math.floor(Math.random() * 16)];
    }
    return color;
  };

  const classNames = Object.keys(data[0]?.points || {});

  const colors = classNames.map(() => getRandomColor());

  return (
    <div className="w-full rounded-3xl border bg-white p-6 pb-2 shadow-md">
      <div className="mb-6 flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
        <h2 className="text-xl font-semibold text-[#2E3A59]">
          Class Performance
        </h2>
        <select
          value={selectedMonth}
          onChange={(e) => setSelectedMonth(e.target.value)}
          className="w-full rounded-lg border border-[#4D44B5] bg-white px-4 py-2 text-[#4D44B5] transition-all duration-300 hover:bg-[#4D44B5] hover:text-white focus:outline-none focus:ring-2 focus:ring-[#4D44B5] focus:ring-offset-2 sm:w-48 "
        >
          {months.map((month) => (
            <option
              key={month}
              value={month}
              className="bg-white text-[#4D44B5]"
            >
              {month}
            </option>
          ))}
        </select>
      </div>

      <div className="h-[400px] w-full">
        <ResponsiveContainer width="100%" height="100%">
          <BarChart data={filteredData} barGap={8} barCategoryGap={32}>
            <CartesianGrid strokeDasharray="3 3" stroke="#F0F0F0" />

            <YAxis
              tick={{ fill: "#303972" }}
              axisLine={{ stroke: "#E2E8F0" }}
              tickLine={false}
            />
            <Tooltip content={<CustomTooltip />} />
            <Legend
              wrapperStyle={{
                paddingTop: "20px",
              }}
            />

            {classNames.map((className, index) => (
              <Bar
                key={className}
                dataKey={`points.${className}`}
                fill={colors[index % colors.length]}
                name={className}
                radius={[4, 4, 0, 0]}
              />
            ))}
          </BarChart>
        </ResponsiveContainer>
      </div>
    </div>
  );
};

export default ClassPerformanceChart;
