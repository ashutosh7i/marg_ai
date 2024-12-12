const nthNumber = (number) => {
  if (number > 3 && number < 21) return "th";
  switch (number % 10) {
    case 1:
      return "st";
    case 2:
      return "nd";
    case 3:
      return "rd";
    default:
      return "th";
  }
};

export const ordinalDate = (date, fullYear = false) => {
  return `${new Date(date).getDate()}${nthNumber(
    new Date(date).getDate()
  )} ${new Date(date).toLocaleString("en-US", {
    month: "short",
  })} ${fullYear ? new Date(date).getFullYear() : ""}`;
};
