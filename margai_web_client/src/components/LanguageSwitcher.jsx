import i18n from "i18next";

const LanguageSwitcher = () => {
  const handleChangeLanguage = (event) => {
    const selectedLanguage = event.target.value;
    i18n.changeLanguage(selectedLanguage);
  };

  return (
    <select onChange={handleChangeLanguage} defaultValue={i18n.language}>
      <option value="en">English</option>
      <option value="fr">Français</option>
    </select>
  );
};

export default LanguageSwitcher;
