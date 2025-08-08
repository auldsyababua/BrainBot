import { Component, ReactNode, ErrorInfo } from 'react';
import { AlertTriangle, RefreshCw } from 'lucide-react';
interface ErrorBoundaryProps {
  children: ReactNode;
}
interface ErrorBoundaryState {
  hasError: boolean;
  errorType: 'network' | 'auth' | 'server' | 'unknown';
  retryCount: number;
  error?: Error;
}
export class ErrorBoundary extends Component<ErrorBoundaryProps, ErrorBoundaryState> {
  constructor(props: ErrorBoundaryProps) {
    super(props);
    this.state = {
      hasError: false,
      errorType: 'unknown',
      retryCount: 0
    };
  }
  static getDerivedStateFromError(error: Error): ErrorBoundaryState {
    // Determine error type based on error message
    let errorType: 'network' | 'auth' | 'server' | 'unknown' = 'unknown';
    if (error.message.includes('network') || error.message.includes('fetch')) {
      errorType = 'network';
    } else if (error.message.includes('auth') || error.message.includes('401')) {
      errorType = 'auth';
    } else if (error.message.includes('server') || error.message.includes('500')) {
      errorType = 'server';
    }
    return {
      hasError: true,
      errorType,
      retryCount: 0,
      error
    };
  }
  componentDidCatch(error: Error, errorInfo: ErrorInfo) {
    console.error('Error caught by ErrorBoundary:', error, errorInfo);
    // In production, you would log this to a service like Sentry
  }
  handleRetry = () => {
    this.setState(prevState => ({
      hasError: false,
      retryCount: prevState.retryCount + 1
    }));
  };
  renderErrorMessage() {
    const {
      errorType
    } = this.state;
    switch (errorType) {
      case 'network':
        return 'Network connection issue. Please check your internet connection and try again.';
      case 'auth':
        return 'Authentication error. Please restart the app and try again.';
      case 'server':
        return 'Server error. Our team has been notified and is working on a fix.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }
  render() {
    if (this.state.hasError) {
      return <div className="flex flex-col items-center justify-center h-screen p-4 bg-gray-50 dark:bg-gray-900 text-center">
          <AlertTriangle size={48} className="text-amber-500 mb-4" />
          <h2 className="text-xl font-semibold mb-2">Oops!</h2>
          <p className="mb-6 text-gray-600 dark:text-gray-300">
            {this.renderErrorMessage()}
          </p>
          <button onClick={this.handleRetry} className="flex items-center justify-center gap-2 bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-md transition-colors">
            <RefreshCw size={16} />
            Try Again
          </button>
          <p className="mt-4 text-sm text-gray-500">
            If the problem persists, please restart the app.
          </p>
        </div>;
    }
    return this.props.children;
  }
}