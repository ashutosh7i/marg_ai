import { Link } from "react-router";
// import { useTranslation } from "react-i18next";

function SignIn() {
  // const { t } = useTranslation();

  return (
    <article className="grid min-h-screen grid-cols-1 pl-36 lg:grid-cols-[40%_60%]">
      <section className="h-full flex-col items-center justify-center lg:flex">
        <div className="h-full flex-col justify-center px-2 py-8 lg:flex">
          <header className="mb-4">
            <h1 className="mb-2 text-xl font-semibold text-[#0C1421] md:text-2xl lg:text-3xl">
              {/* {t("welcomeMsg")} */}
              Welcome Back
            </h1>
            <p className="text-sm font-normal text-[#313957] md:text-base lg:text-sm">
              Today is a new day. It&apos;s your day.
              <br />
              Sign in to start managing your assessments.
            </p>
          </header>

          <form className="flex flex-col gap-4">
            <fieldset className="flex flex-col gap-1.5">
              <label
                htmlFor="email"
                className="text-xs font-normal text-[#0C1421]"
              >
                Email
              </label>
              <input
                type="email"
                id="email"
                className="h-8 w-full rounded-lg border-2 border-[#D4D7E3] bg-[#F7FBFF] px-3 text-sm"
                placeholder="Example@email.com"
                required
              />
            </fieldset>

            <fieldset className="flex flex-col gap-1.5">
              <label
                htmlFor="password"
                className="text-xs font-normal text-[#0C1421]"
              >
                Password
              </label>
              <input
                type="password"
                id="password"
                className="h-8 w-full rounded-lg border-2 border-[#D4D7E3] bg-[#F7FBFF] px-3 text-sm"
                placeholder="at least 8 characters"
                required
              />
            </fieldset>

            <div className="flex justify-end">
              <a href="#" className="text-xs font-normal text-[#1E4AE9]">
                Forgot Password?
              </a>
            </div>

            <Link to="/teacher">
              <button className="h-9 w-full rounded-lg bg-[#162D3A] text-sm font-medium text-white">
                Sign In
              </button>
            </Link>
          </form>

          <div
            role="separator"
            className="my-5 flex items-center justify-center gap-3 md:my-6"
          >
            <div className="h-[1px] flex-1 bg-[#CFDFE2]"></div>
            <span className="text-xs text-[#294957]">Or</span>
            <div className="h-[1px] flex-1 bg-[#CFDFE2]"></div>
          </div>

          <nav className="mb-6 flex flex-col gap-3">
            <button
              type="button"
              className="flex h-9 w-full items-center justify-center gap-2 rounded-lg border border-[#EEE] bg-[#FAFAFA] text-xs"
            >
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="19"
                height="19"
                viewBox="0 0 19 19"
                fill="none"
              >
                <mask
                  id="mask0_13_573"
                  style={{ maskType: "luminance" }}
                  maskUnits="userSpaceOnUse"
                  x="0"
                  y="0"
                  width="19"
                  height="19"
                >
                  <rect
                    x="0.5"
                    y="0.547852"
                    width="18"
                    height="18"
                    fill="white"
                  />
                </mask>
                <g mask="url(#mask0_13_573)">
                  <path
                    fillRule="evenodd"
                    clipRule="evenodd"
                    d="M16.8541 8.07898H16.25V8.04785H9.5V11.0479H13.7386C13.1203 12.7942 11.4586 14.0479 9.5 14.0479C7.01488 14.0479 5 12.033 5 9.54785C5 7.06273 7.01488 5.04785 9.5 5.04785C10.6471 5.04785 11.6908 5.4806 12.4854 6.18748L14.6067 4.0661C13.2673 2.81773 11.4755 2.04785 9.5 2.04785C5.35813 2.04785 2 5.40598 2 9.54785C2 13.6897 5.35813 17.0479 9.5 17.0479C13.6419 17.0479 17 13.6897 17 9.54785C17 9.04498 16.9482 8.5541 16.8541 8.07898Z"
                    fill="#FFC107"
                  />
                  <path
                    fillRule="evenodd"
                    clipRule="evenodd"
                    d="M2.86475 6.05698L5.32887 7.8641C5.99562 6.21335 7.61037 5.04785 9.5 5.04785C10.6471 5.04785 11.6907 5.4806 12.4854 6.18748L14.6067 4.0661C13.2672 2.81773 11.4755 2.04785 9.5 2.04785C6.61925 2.04785 4.121 3.67423 2.86475 6.05698Z"
                    fill="#FF3D00"
                  />
                  <path
                    fillRule="evenodd"
                    clipRule="evenodd"
                    d="M9.50012 17.0481C11.4374 17.0481 13.1976 16.3067 14.5285 15.1011L12.2072 13.1369C11.4542 13.7072 10.5182 14.0481 9.50012 14.0481C7.54937 14.0481 5.89299 12.8042 5.26899 11.0684L2.82324 12.9527C4.06449 15.3816 6.58524 17.0481 9.50012 17.0481Z"
                    fill="#4CAF50"
                  />
                  <path
                    fillRule="evenodd"
                    clipRule="evenodd"
                    d="M16.8541 8.07898H16.25V8.04785H9.5V11.0479H13.7386C13.4416 11.8867 12.902 12.6101 12.206 13.137C12.2064 13.1366 12.2068 13.1366 12.2071 13.1362L14.5284 15.1005C14.3641 15.2497 17 13.2979 17 9.54785C17 9.04498 16.9482 8.5541 16.8541 8.07898Z"
                    fill="#1976D2"
                  />
                </g>
              </svg>

              <span className="text-[#616161]">Sign Up with Google</span>
            </button>

            <button
              type="button"
              className="flex h-9 w-full items-center justify-center gap-2 rounded-lg border border-[#EEE] bg-[#FAFAFA] text-xs"
            >
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="14"
                height="19"
                viewBox="0 0 14 19"
                fill="none"
              >
                <mask
                  id="mask0_13_589"
                  style={{ maskType: "luminance" }}
                  maskUnits="userSpaceOnUse"
                  x="0"
                  y="0"
                  width="14"
                  height="19"
                >
                  <rect
                    x="0.5"
                    y="0.452637"
                    width="13.5"
                    height="18"
                    fill="white"
                  />
                </mask>
                <g mask="url(#mask0_13_589)">
                  <path
                    fillRule="evenodd"
                    clipRule="evenodd"
                    d="M11.7043 9.8991C11.6973 8.60887 12.2809 7.63504 13.4621 6.91785C12.8012 5.97215 11.8027 5.45184 10.4844 5.34988C9.23633 5.25144 7.87227 6.07762 7.37305 6.07762C6.8457 6.07762 5.63633 5.38504 4.68711 5.38504C2.72539 5.41668 0.640625 6.94949 0.640625 10.0679C0.640625 10.9889 0.809375 11.9405 1.14687 12.9225C1.59688 14.2128 3.22109 17.3768 4.91563 17.3241C5.80156 17.303 6.42734 16.6948 7.58047 16.6948C8.69844 16.6948 9.27852 17.3241 10.2664 17.3241C11.975 17.2995 13.4445 14.4237 13.8734 13.13C11.5813 12.0507 11.7043 9.9659 11.7043 9.8991L11.7043 9.8991ZM9.71444 4.12646C10.6742 2.9874 10.5863 1.95029 10.5582 1.57764C9.71093 1.62686 8.73007 2.1542 8.17108 2.80459C7.55585 3.50068 7.19374 4.36201 7.27108 5.33232C8.18866 5.40264 9.02538 4.93154 9.71444 4.12646Z"
                    fill="black"
                  />
                </g>
              </svg>

              <span className="text-[#616161]">Sign up with Apple</span>
            </button>
          </nav>

          <p className="text-center text-xs font-normal text-[#313957]">
            Don&apos;t have an account?{" "}
            {/* <Link to="/sign-up" className="text-[#1E4AE9]"> */}
            Sign Up
            {/* </Link> */}
          </p>
        </div>
      </section>

      <section className="flex w-full bg-[#F7FBFF] p-4">
        <img
          src="img/login.png"
          alt="Login illustration"
          className="h-full w-[85%] rounded-[5rem] py-2"
        />
      </section>
    </article>
  );
}

export default SignIn;
