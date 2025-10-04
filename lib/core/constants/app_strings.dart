  class AppStrings {
    const AppStrings();
  
    static const String appName = "Beseda";
  }
  
  class AppCommonStrings extends AppStrings {
    static const String btnNext = "Напред";
    static const String btnPrevious = "Назад";
    static const String btnBack = "Върни се";
    static const String btnDone = "Готово";
    static const String btnSave = "Запази";
    static const String btnUpdate = "Актуализирай";
    static const String btnVerify = "Потвърди";
    static const String btnGetStarted = "Започни";
    static const String btnSignIn = "Вход";
    static const String btnSignUp = "Регистрация";
    static const String btnNo = "Не";
    static const String btnApply = "Приложи";
    static const String btnCancel = "Отказ";
    static const String btnRemove = "Премахни";
    static const String yesSignOut = "Да, излез";
    static const String areYouSureYouWantSignOut = "Сигурни ли сте, че искате да излезете?";
    static const String btnAdd = "Добави";
    static const String btnSkip = "Пропусни";
    static const String btnContinue = "Продължи";
    static const String btnSendCode = "Изпрати код";
    static const String btnBackToLogIn = "Назад към вход";
  
    static const String searchHint = "Търси храна, напитки, ресторанти и др.";
    static const String viewAll = "Виж всички";
    static const email = "Имейл";
    static const password = "Парола";
  }
  
  class PermissionStrings extends AppStrings {
    static const String goToSettings = "Отиди в настройките";
    static const String permissionNotGranted = "Разрешението не е дадено!";
    static const String permissionNotGrantedDesc = "Няма дадено разрешение за";
    static const String permissionToEnable = "за да активирате";
    static const String permissionContact = "контакти";
    static const String descContactPermission = "дайте достъп до вашите контакти";
    static const String permissionCamera = "камера";
    static const String descCameraPermission = "дайте достъп до камерата";
    static const String permissionPhotos = "снимки";
    static const String descPhotosPermission = "дайте достъп до снимките";
    static const String permissionLocation = "местоположение";
    static const String descLocationPermission = "дайте достъп до местоположението";
    static const String permissionLocationAlways = "винаги местоположение";
    static const String descAlwaysLocationPermission =
        "дайте постоянно разрешение за местоположение";
    static const String permissionStorage = "хранилище";
    static const String descStoragePermission = "дайте достъп до хранилището";
    static const String descLocationGet =
        "моля, дръжте sun sirius отворено или на заден план, за да осигурите точни и актуализирани данни за местоположението.";
    static const String titleLocationGet = "актуализирай дневник на местоположението и ниво на доверие";
    static const String locationLogsAndTrustSystem =
        "дневници на местоположението и система за доверие";
    static const String locationPermissionDescription =
        "моля, настройте споделянето на местоположението си на \"винаги\". това ще гарантира, че дневниците и нивото на доверие са точно актуализирани. ще вземаме местоположението ви веднъж на час.";
    static const String locationPermission = "местоположение";
    static const String allow = "разреши";
  }
  
  class OnboardingStrings extends AppStrings {
    static const String onboardingTitleOne = "Следващо поколение обучение на върха на пръстите ви";
    static const String onboardingTitleTwo =
        "Чат в реално време за обучение в реално време";
    static const String onboardingTitleThree =
        "Ясни, лични и на живо учебни сесии";
  
  
    static const String onboardingSubtitleOne = "Учи по-умно с интерактивни уроци, експертно съдържание и проследяване на напредъка – всичко в едно приложение.";
    static const String onboardingSubtitleTwo =
        "Получавай незабавни отговори и персонализирано ръководство чрез чат на живо – твоят учител е винаги само на едно съобщение разстояние";
    static const String onboardingSubtitleThree =
        "Интерактивни сесии на живо, които правят обучението ясно, лично и ангажиращо";
  }
  
  class SignInStrings extends AppStrings {
    static const welcomeBack =
        "Добре дошли отново! Нека продължим вашето учебно пътешествие.";
    static const enterCredentials = "Въведете данни за вход, за да се впишете успешно";
    static const enterEmailId = "Въведете имейл";
    static const enterPassword = "Въведете парола";
    static const rememberMe = "Запомни ме";
    static const forGotPassword = "Забравена парола?";
    static const or = "или";
    static const loginWithGoogle = "Вход с Google";
    static const loginWithApple = "Вход с Apple";
    static const doNotHaveAnAccount = "Нямате акаунт все още?";
  }
  
  class SignUpStrings extends AppStrings {
    static const startYourLearningJourney =
        "Започнете вашето учебно пътешествие – създайте акаунт сега!";
    static const enterBelowDetail = "Въведете детайлите по-долу и създайте акаунт";
    static const name = "Име";
    static const enterName = "Въведете име";
    static const phoneNumber = "Телефонен номер";
    static const enterMobileNo = "Въведете мобилен номер";
    static const confirmPassword = "Потвърдете парола";
    static const enterConfirmPassword = "Въведете потвърждение на паролата";
    static const forGotPassword = "Забравена парола?";
    static const or = "или";
    static const loginWithGoogle = "Вход с Google";
    static const loginWithApple = "Вход с Apple";
    static const alreadyHaveAnAccount = "Вече имате акаунт?";
    static const verifyYourEmail =
        "Потвърдете имейла си с линк и получете достъп до приложението";
  }
  
  class ForgotPasswordStrings extends AppStrings {
    static const forgotPasswordTitle =
        "Забравена парола? Не се притеснявайте потвърдете имейла си и нулирайте паролата";
    static const forgotPasswordDes = "Въведете имейл, за да получите код за потвърждение";
    static const sendCode = "Изпрати код";
  }
  class OtpVerificationStrings extends AppStrings {
    static const otpVerifyTitle =
        "Потвърдете имейла си с линк и нулирайте паролата си";
    static const otpVerifyDes =
        "Въведете 4-цифрен код за потвърждение, който ви изпратихме на ";
    static const didNotReceiveCode = "Не получихте код?";
    static const resend = "Изпрати отново";
    static const String verifyEmail = "Потвърди имейл";
    static const String otpSendSuccessfully = "Линк изпратен успешно.. ";
  }
  
  
  class ResetPasswordStrings extends AppStrings {
    static const resetYourPassword = "Нулирай паролата си";
    static const resetYourPasswordDes =
        "Нулирай паролата си и тя трябва да бъде различна от предишната";
    static const newPassword = "Нова парола";
    static const confirmPassword = "Потвърди парола";
    static const resetPassword = "Нулирай парола";
    static const mustBe8character = "Трябва да е поне 8 символа";
    static const mustBeOneSpecialCharacter = "Трябва да съдържа един специален символ";
    static const passwordMatch = "Паролите съвпадат";
  }
  
  class ResetPasswordSuccessfullyStrings extends AppStrings {
    static const congratulations = "Поздравления!";
    static const congratulationsDes =
        "Вашата нова парола е зададена успешно, можете да влезете с новата парола";
    static const goToSignIn = "Отиди на вход";
  }
  
  
  class ProfileSetUpStrings extends AppStrings {
    static const lets = "Нека";
    static const personalised = "Персонализираме";
    static const personalisedDes = "вашето учебно изживяване";
  }
  
  
  class InterestOrSubjectStrings extends AppStrings {
    static const whatWouldYouLike = "Какво бихте искали да научите?";
  }
  
  
  class LearningGoalsStrings extends AppStrings {
    static const setTourLearningGoals = "Задайте вашите учебни цели";
    static const prepareForExam = "Подгответе се за изпит";
    static const improveMyCodingSkill = "Подобрете уменията си по програмиране";
    static const updateForANewJob = "Подобрете уменията си за нова работа";
  }
  
  
  class SkillLevelStrings extends AppStrings {
    static const whoAreYou = "Кой сте вие тук?";
    static const beginner = "Начинаещ";
    static const intermediate = "Средно ниво";
    static const advanced = "Напреднал";
    static const iAmReadyToLearn = "Готов съм да уча";
  }
  
  
  class BottomViewStrings extends AppStrings {
    static const home = "Начало";
    static const myCourses = "Моите курсове";
    static const wishlist = "Желани";
    static const setting = "Настройки";
  }
  
  class HomeViewStrings extends AppStrings {
    static const searchAnything = "Търси...";
    static const onGoingCourses = "Текущи курсове";
    static const browseByCategories = "Разгледай по категории";
    static const seeAll = "Виж всички";
    static const featuredCourse = "Препоръчани курсове по";
    static const designing = "Дизайн";
    static const exclusiveUniversity = "Ексклузивно партньорство с университет";
    static const topRecommendedCourse = "Топ препоръчани курсове";
    static const viewCourse = "Виж курса";
    static const letsTakeAQuiz = "Нека направим бърз тест!";
    static const topRatedCourses = "Курсове с най-висока оценка";
    static const aiPoweredLearning = "Обучение с AI";
    static const aiPoweredLearningDes =
        "Получете учебно изживяване, което се адаптира към вас. От ежедневни уроци до персонализирани тестове и проследяване на напредъка, нашият AI ви помага да останете фокусирани и мотивирани.";
    static const simulateTheExam = "Симулирайте реалния изпит";
    static const mockTest = "(Пробен тест)";
    static const questions = "Въпроси";
    static const completed = "Завършено";
    static const startTest = "Започни тест";
  }
  
  class NotificationViewStrings extends AppStrings {
    static const notification = "Известие";
    static const markAsUnread = "Маркирай като непрочетено";
    static const markAsRead = "Маркирай като прочетено";
    static const clearAll = "Изчисти всички";
    static const today = "Днес";
    static const yesterday = "Вчера";
    static const caughtUp = "Наваксахте всичко!";
    static const caughtUpDes =
        "Проверете по-късно за актуализации, напомняния или известия за курсове.";
    static const confirmation = 'Потвърждение';
    static const deleteMessage = 'Изтрий съобщение';
    static const deleteMessageDes =
        'Сигурни ли сте, че искате да изтриете това съобщение?';
    static const delete = 'Изтрий';
    static const notificationDeleteSuccessfully = 'Известието е изтрито успешно';
    static const notificationMarkAsReadSuccessfully = 'Маркирано като прочетено успешно';
    static const notificationMarkAsUnReadSuccessfully = 'Маркирано като непрочетено успешно';
  }
  
  class MyProfileViewStrings extends AppStrings {
    static const myProfile = "Моят профил";
    static const courseEnrolled = "Записани курсове";
    static const averageScore = "Среден резултат";
    static const daysInLearning = "Дни в обучение";
    static const totalCoins = "Общо монети";
    static const onGoing = "В процес";
  }
  
  
  class EditProfileViewStrings extends AppStrings {
    static const editProfile = "Редактирай профил";
    static const updateProfile = "Актуализирай профил";
    static const selectImage = "Избери изображение";
    static const areYouSure = 'Сигурни ли сте?';
    static const wantToDeleteProfileImg = 'Искате да изтриете профилната снимка?';
    static const profileRemoveSuccessfully = 'Профилът е премахнат успешно.';
    static const pickImageFromCamera = 'Избери снимка от камерата';
    static const pickImageFromGallery = 'Избери снимка от галерията';
  }
  
  
  class SearchViewStrings extends AppStrings {
    static const search = "Търсене";
    static const topSearches = "Топ търсения";
    static const smartCoursesForYou = "Умни курсове за вас";
    static const browseByCategory = "Разгледай по категория";
    static const bestseller = "Бестселър";
    static const viewMore = "Виж повече";
    static const oopsNothingFound = "Опа! Нищо не е намерено";
    static const oopsNothingFoundDes =
        "Опитайте да прецизирате търсенето или разгледайте популярни курсове.";
  }
  
  
  class CourseCategoryDetailStrings extends AppStrings {
    static const courseToGetStarted = "Курс за започване";
    static const topInstructor = "Топ инструктор по";
    static const relatedCourses = "Свързани курсове";
  }
  
  
  class CourseDetailStrings extends AppStrings {
    static const buyNow = "Купи сега";
    static const addToWatchList = "Добави в желани";
    static const viewCart = "Виж количката";
    static const learningOutComes = "Резултати от този курс";
    static const curriculum = "Учебна програма";
    static const ratingReview = "Оценки и отзиви";
    static const courseFeature = "Характеристики на курса";
    static const requirements = "Изисквания";
    static const instructor = "Преподавател";
    static const youMayAlsoLike = "Може също да харесате";
    static const courseRating = "Оценка на курса";
    static const viewMoreReviews = "Виж повече отзиви";
  }
  
  class CourseCartStrings extends AppStrings {
    static const cart = "Количка";
    static const moveToWishList = "Премести в желани";
    static const useCoins = "Използвай монети";
    static const enterCoinsQuantity = "Въведи количество монети";
    static const emptyCart = "Количката е празна!";
    static const emptyCartDes =
        "Количката ви е празна! Изглежда, че все още не сте добавили\n нищо в нея";
    static const proceedToCheckout = "Продължи към плащане";
    static const removeFromCart = "Премахни от количката";
    static const removeFromCartDes =
        "Сигурни ли сте, че искате да премахнете този артикул от количката си?";
    static const itemRemovedSuccessfully = "Артикулът е премахнат от количката успешно.";
    static const itemRemoved = "Артикулът е премахнат успешно.";
    static const itemAddedSuccessfully = "Артикулът е добавен в желани успешно.";
  
    static const exploreCourses = "Разгледай курсове";
  }
  
  class CourseCheckoutStrings extends AppStrings {
    static const checkout = "Плащане";
    static const billingAddress = "Адрес за фактуриране";
    static const country = "Държава";
    static const selectCountry = "Изберете държава";
    static const state = "Щат / Област";
    static const selectState = "Изберете щат / област";
    static const paymentMethod = "Метод на плащане";
    static const creditDebitCard = "Кредитна / Дебитна карта";
    static const cardNumber = "Номер на картата";
    static const cardNo = "1234 5678 9012 3456";
    static const cardHolderName = "Име на притежателя на картата";
    static const enterCardHolderName = "Въведете име на притежателя на картата";
    static const expiryDate = "Дата на валидност";
    static const cvv = "CVV / CVC";
    static const enterCvv = "Въведете CVV";
    static const uPI = "UPI";
    static const uPIId = "UPI ID";
    static const enterUPId = "Въведете UPI ID";
    static const payPal = "Paypal";
    static const razorPay = "Razor pay";
    static const searchCountry = "Търси държава";
    static const searchState = "Търси щат / област";
    static const noCountryFound = "Няма намерена държава";
    static const noStateFound = "Няма намерен щат / област";
  }
  
  class PaymentViewStrings extends AppStrings {
    static const paymentSuccessTitle = "Успешно плащане";
    static const paymentProcessTitle = "Плащането се обработва";
    static const paymentFailedTitle = "Неуспешно плащане";
    static const paymentSuccess =
        "Поздравления! Плащането е завършено и вашият курс е готов за използване.";
    static const paymentProcess =
        "Вашето плащане се обработва. Моля, изчакайте момент...";
    static const paymentFailed =
        "Плащането е неуспешно! Моля, опитайте отново или използвайте друг метод на плащане.";
    static const goToHome = "Отиди в началото";
  }
  
  class TrainerProfileDetailStrings extends AppStrings {
    static const students = "Студенти";
    static const courses = "Курсове";
    static const reviews = "Отзиви";
    static const about = "За мен";
    static const description =
        "Beseda е създадено като пространство за експериментиране и развитие – място, където технологиите срещат креативността. Чрез него искам да покажа как изкуственият интелект може да бъде едновременно полезен, интересен и достъпен за всеки. За мен това е само началото на пътешествието в света на AI, а Beseda е първата стъпка към реализирането на по-големи идеи и проекти.";
    static const connectMe = "Свържи се с мен ";
    static const facebook = "Facebook";
    static const instagram = "Instagram";
    static const youTube = "YouTube";
  }
  
  class AllUniversityListStrings extends AppStrings {
    static const exclusiveUniversityPartnership =
        "Ексклузивно партньорство с университет";
  }
  
  class UniversityDetailViewStrings extends AppStrings {
    static const availableCourses = "Налични курсове";
  }
  
  class QuizListStrings extends AppStrings {
    static const quiz = "Тест";
  }
  
  class QuizScreenStrings extends AppStrings {
    static const question = "Въпрос";
    static const selectOption = "Избери отговор";
    static const previousQuestion = "Предишен въпрос";
    static const nextQuestion = "Следващ въпрос";
    static const submitQuiz = "Предай тест";
    static const answers = "Отговори";
    static const logoDesignTest = "Тест по дизайн на лого";
  }
  
  class QuizSubmittedStrings extends AppStrings {
    static const quizCompleted = "Тестът е завършен!";
    static const quizCompletedDes =
        "Страхотна работа, че завършихте теста! Нека продължим да изграждаме вашите знания.";
    static const viewAnswer = "Виж отговор";
    static const viewLeaderBoard = "Виж класиране";
  }
  
  class LeaderBoardStrings extends AppStrings {
    static const leaderBoard = "Класиране";
    static const findMe = "Намери ме";
    static const backToTop = "Обратно в началото";
    static const rank = "Ранг";
    static const score = "Резултат";
  }
  
  class QuizPopUpStrings extends AppStrings {
    static const continueQuiz = "Продължи теста";
    static const leaveQuiz = "Напусни теста";
    static const leaveQuizDescription =
        "На път сте да напуснете теста. Целият ви текущ напредък ще бъде загубен. Искате ли да продължите?";
  }
  
  class TestPopUpStrings extends AppStrings {
    static const testDes =
        "На път сте да напуснете изпита. Целият ви текущ напредък ще бъде загубен. Искате ли да продължите?";
    static const continueTest = "Продължи изпита";
    static const leaveTest = "Напусни изпита";
  }
  
  class AiLearningStrings extends AppStrings {
    static const yourAiAssistant = "Вашият AI асистент";
    static const suggestedCoursesForYou = "Предложени курсове за вас";
    static const personalizedCourses = "Персонализирани курсове с AI";
    static const askAiTutor = "Попитай AI преподавател";
    static const askAiTutorDes =
        "Здравей! Аз съм твоят AI асистент за учене. Попитай ме всичко – от трудни теми до кратки обобщения – ще ти помогна да разбираш по-добре и да учиш по-умно.";
    static const smartRecommendation =
        "Умни препоръки за всеки дизайнер";
  }
  
  class AiChatbotStrings extends AppStrings {
    static const tutorAI = "TutorAI";
    static const alwaysActive = "Винаги активен";
    static const typeMessage = "Въведи съобщение";
  }
  
  class MyCoursesStrings extends AppStrings {
    static const courseStatus = "Статус на курса";
  }
  
  class SingleCoursesStrings extends AppStrings {
    static const chatWithTutor = "Чат с преподавател";
    static const enhanceYourLearning = "Подобрете учебното си изживяване с AI";
    static const summarizeVideo =
        "Обобщи видео с AI и вземи основните точки на тази лекция";
    static const viewSummarise = "Виж обобщение";
    static const convertVideo = "Конвертирай видео";
    static const convert = "Конвертирай";
    static const getCertificate = "Вземи сертификат";
    static const join = "Присъедини се";
  }
  
  class SummarizeVideoStrings extends AppStrings {
    static const summarizeVideoKeyPoints = "Обобщено видео и ключови точки";
    static const keyPoints = "Ключови точки";
    static const description =
        "Lorem ipsum dolor sit amet consectetur. Sagittis phasellus faucibus amet imperdiet. Lorem ipsum dolor sit amet consectetur. Sagittis phasellus, Lorem ipsum dolor sit amet consectetur. Sagittis phasellus faucibus amet imperdiet. Lorem ipsum dolor sit amet consectetur. Sagittis phasellus.";
  }
  
  class VideoToTextStrings extends AppStrings {
    static const videoToText = "Видео към текст";
    static const translation = "Превод";
    static const convertTextInto = "Конвертирай текста в глас с AI";
  }
  
  class TextToVoiceStrings extends AppStrings {
    static const textToVoice = "Текст към глас";
    static const textToVoiceDes =
        "Дизайн на лого в Adobe Illustrator – 10 графични инструмента";
  }
  
  class CompletedTestStrings extends AppStrings {
    static const wellDoneChampion = "Браво, шампионе!";
    static const wellDoneChampionDes =
        "Завършихте теста и се справихте блестящо!\n Продължавайте в същия дух.";
    static const aSolidAttempts = "Добър опит!";
    static const aSolidAttemptsDes =
        "Това беше добро начало! Прегледайте слабите места\n и опитайте отново.";
    static const keepTrying = "Продължавай да опитваш!";
    static const keepTryingDes =
        "Нисък резултат? Няма проблем – това е част от ученето, \nпродължавайте и ще се подобрите.";
  }
  
  class FeedbackStrings extends AppStrings {
    static const feedback = "Обратна връзка";
    static const yourFeedback = "Вашата обратна връзка ни помага да се подобряваме.";
    static const yourFeedbackDes =
        "Как беше вашето учебно пътешествие? Вашата обратна връзка прави нашата платформа по-добра всеки ден.";
    static const shareYourThoughts = "Споделете вашите мисли тук...";
    static const sendFeedBack = "Изпрати обратна връзка";
  }
  
  class FeedbackSubmittedStrings extends AppStrings {
    static const feedbackSubmitted = "Обратната връзка е изпратена";
    static const feedbackHasBeenSubmitted =
        "Вашата обратна връзка беше успешно\n изпратена";
    static const backToHome = "Обратно в началото";
  }
  
  class WishlistStrings extends AppStrings {
    static const noCourseSavedYet = "Все още няма запазени курсове";
    static const noCourseSavedYetDes =
        "Добавете любимите си курсове в желани и\n започнете да учите по-умно.";
    static const removeFromWishlist = "Премахване от желани?";
    static const removeFromWishlistDes =
        "Сигурни ли сте, че искате да изтриете този курс от желани?";
  }
  
  class CourseCertificateStrings extends AppStrings {
    static const courseCompleted = "Курсът е завършен";
    static const congratulationOnMastering = "Поздравления за усвояването на";
    static const youHaveSuccessfully =
        "Успешно завършихте курса на 20 август 2024";
    static const downloadCertificate = "Изтегли сертификат";
    static const certificateDownloadSuccessfully =
        "Сертификатът е изтеглен успешно";
  }
  
  class MeetingPermissionStrings extends AppStrings {
    static const enablePermission = "Активирай разрешения";
    static const grantPermissionDes =
        "Просто дайте няколко разрешения, преди да се присъедините";
    static const grantPermission = "Дай разрешение";
  }
  
  class MeetingJoiningStrings extends AppStrings {
    static const setUpAudio = "Настройте аудио и видео преди присъединяване";
    static const peopleInSession = "Още 23 участници";
    static const live = "НА ЖИВО";
    static const joinNow = "Присъедини се сега";
    static const enterName = "Въведете име...";
  }
  
  class YetToStartString extends AppStrings {
    static const classYetToStart = "Класът все още не е започнал";
    static const sitBackAndRelax = "Отпуснете се и изчакайте";
  }
  
  class ParticipantsString extends AppStrings {
    static const participants = "Участници";
    static const findWhom = "Намерете когото търсите";
    static const host = "Домакин";
    static const leaveSession = "Напусни сесията";
    static const leaveSessionDes =
        "Другите ще продължат след като напуснете. Можете да се присъедините отново.";
  }
  
  class LeaveSessionString extends AppStrings {
    static const youLeftTheSession = "Напуснахте сесията";
    static const youLeftTheSessionDes =
        "Напуснахте сесията, можете да се присъедините отново\n ако сте напуснали по грешка";
    static const reJoin = "Присъедини се отново";
    static const onlineLiveClass = "Онлайн час на живо";
  }
  
  class SettingString extends AppStrings {
    static const myDownloads = "Моите изтегляния";
    static const languagePreference = "Езикови предпочитания";
    static const changePassword = "Смени парола";
    static const aiChatbot = "AI чатбот";
    static const darkMode = "Тъмен режим";
    static const myProgress = "Моят напредък";
    static const faq = "ЧЗВ";
    static const contactUs = "Свържете се с нас";
    static const privacyPolicy = "Политика за поверителност";
    static const logout = "Изход";
  }
  
  class MyDownloadsString extends AppStrings {
    static const myDownloads = "Моите изтегляния";
    static const videoLectures = "Видео лекции";
    static const documents = "Документи";
    static const audio = "Аудио";
    static const rename = "Преименувай";
    static const delete = "Изтрий";
    static const share = "Сподели";
    static const deleteVideo = "Изтрий видео";
    static const deleteVideoDes = "Сигурни ли сте, че искате да изтриете това видео?";
    static const videoDeleteSuccessfully = 'Видеото е изтрито успешно';
    static const videoUpdateSuccessfully = 'Името е обновено успешно';
    static const documentDeleteSuccessfully = 'Документът е изтрит успешно';
    static const audioDeleteSuccessfully = 'Аудиото е изтрито успешно';
  
    static const deleteDocument = "Изтрий документ";
    static const deleteDocumentDes =
        "Сигурни ли сте, че искате да изтриете този документ?";
  
    static const deleteAudio = "Изтрий аудио";
    static const deleteAudioDes = "Сигурни ли сте, че искате да изтриете това аудио?";
  }
  
  class LanguagePreferenceString extends AppStrings {
    static const chooseLanguage = "Изберете език";
    static const setLanguage = "Задай език";
  }
  
  class ChangePasswordString extends AppStrings {
    static const currentPassword = "Текуща парола";
    static const enterCurrentPassword = "Въведете текуща парола";
    static const enterNewPassword = "Въведете нова парола";
    static const confirmNewPassword = "Потвърдете нова парола";
    static const enterConfirmNewPassword = "Потвърдете нова парола";
  }
  
  class ChangePasswordSuccessfullyString extends AppStrings {
    static const passwordChangedSuccessfully = "Паролата е сменена успешно";
    static const passwordChangedSuccessfullyDes =
        "Паролата ви беше сменена успешно, можете да влезете с новата парола";
  }
  
  class FaqViewString extends AppStrings {
    static const String faqTitle = "Често задавани въпроси (ЧЗВ)";
    static const faqAns =
              "Приложението предлага интерактивни курсове по изкуствен интелект, машинно обучение, дълбоко обучение, програмиране, анализ на данни и други свързани технологии.";
    static const faqAns1 =
              "Не, курсовете са структурирани на различни нива – от начинаещи до напреднали. Можете да започнете от основите и постепенно да надграждате знанията си.";
    static const faqAns2 =
              "Обучението е интерактивно – включва видеа, упражнения, тестове и проекти, които ви помагат да приложите наученото на практика.";
    static const faqAns3 =
              "Да, всички курсове са достъпни по всяко време, което ви позволява да учите, когато и където ви е удобно.";
    static const faqAns4 =
              "Да, след успешно завършване на курс получавате сертификат, който може да бъде добавен към вашето CV или профил в LinkedIn.";
  }
  
  class ContactUsString extends AppStrings {
    static const String firstName = "Първо име";
    static const String enterFirstName = "Въведете първо име";
    static const String lastName = "Фамилия";
    static const String enterLastName = "Въведете фамилия";
    static const String message = "Съобщение";
    static const String sendMessage = "Изпрати съобщение";
  }
  
  class MyProgressString extends AppStrings {
    static const String startDate = "Начална дата";
    static const String totalLec = "Общо лекции";
    static const String completedLec = "Завършени лекции";
    static const String achievements = "Постижения";
    static const String pointsEarned = "Спечелени точки";
    static const String totalPoints = "Общо точки";
    static const String balancedPoints = "Баланс точки";
    static const String usedPoints = "Използвани точки";
  }
  
  class LogOutString extends AppStrings {
    static const String logOutConfirmation = "Потвърждение за изход";
    static const String logOutConfirmationDes = "На път сте да излезете. Напредъкът ви в ученето е запазен и ще бъде наличен при завръщането ви.";
    static const String stayHere = "Остани тук";
    static const String yesLogout = "Да, излез";
  }
  
  class ConnectionStrings extends AppStrings {
    static const String noConnection = "Опа! В момента сте офлайн!";
    static const String noInternetFound = "Свържете се отново, за да продължите вашето обучение или за да видите изтеглените си файлове.";
    static const String goToDownloads = "Отиди в изтеглени";
  }
