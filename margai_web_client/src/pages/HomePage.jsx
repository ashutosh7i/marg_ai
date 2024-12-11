import LanguageSwitcher from "@/components/LanguageSwitcher";
import { useTranslation } from "react-i18next";
import { Link } from "react-router";

export default function App() {
  const { t } = useTranslation("home");

  return (
    <div>
      <button>
        <Link to="/about">click me</Link>
      </button>
      <br />
      <LanguageSwitcher />
      <h1>{t("welcome")}</h1>
      <p>{t("description")}</p>
    </div>
  );
}
